-- ============================================
-- Rwanda Connect Database Schema for Supabase
-- ============================================
-- Run this in Supabase SQL Editor (Dashboard > SQL Editor > New Query)
--
-- This schema matches your API_SPEC.md and PRD.md data model
-- ============================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- ENUM TYPES
-- ============================================

-- Subscription plans
CREATE TYPE subscription_plan AS ENUM ('free', 'trial', 'monthly', 'yearly');

-- Subscription status
CREATE TYPE subscription_status AS ENUM ('active', 'expired', 'cancelled');

-- Opportunity types
CREATE TYPE opportunity_type AS ENUM ('job', 'investment', 'scholarship', 'tender');

-- Event types
CREATE TYPE event_type AS ENUM ('networking', 'seminar', 'workshop', 'conference');

-- News categories
CREATE TYPE news_category AS ENUM ('Economy', 'Investment', 'Events', 'Business', 'Policy');

-- RSVP status
CREATE TYPE rsvp_status AS ENUM ('going', 'interested', 'not_going');

-- Bookmark entity types
CREATE TYPE bookmark_entity_type AS ENUM ('opportunity', 'event', 'news', 'post');

-- ============================================
-- 1. PROFILES TABLE (extends Supabase auth.users)
-- ============================================

CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    avatar_url TEXT,
    location TEXT,
    interests TEXT[] DEFAULT '{}',
    onboarding_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index for faster lookups
CREATE INDEX idx_profiles_email ON profiles(email);

COMMENT ON TABLE profiles IS 'User profiles extending Supabase auth.users';

-- ============================================
-- 2. SUBSCRIPTIONS TABLE
-- ============================================

CREATE TABLE subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    plan subscription_plan NOT NULL DEFAULT 'free',
    status subscription_status NOT NULL DEFAULT 'active',
    billing_provider TEXT, -- 'stripe', 'app_store', 'play_store', 'mobile_money'
    external_subscription_id TEXT, -- ID from payment provider
    start_date TIMESTAMPTZ DEFAULT NOW(),
    end_date TIMESTAMPTZ,
    trial_ends_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    -- Each user can only have one active subscription
    CONSTRAINT unique_active_subscription UNIQUE (user_id)
);

-- Index for subscription queries
CREATE INDEX idx_subscriptions_user_id ON subscriptions(user_id);
CREATE INDEX idx_subscriptions_status ON subscriptions(status);

COMMENT ON TABLE subscriptions IS 'User subscription and billing information';

-- ============================================
-- 3. NEWS TABLE
-- ============================================

CREATE TABLE news (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    source TEXT NOT NULL,
    category news_category NOT NULL,
    summary TEXT NOT NULL,
    content TEXT, -- Full article content (optional)
    image_url TEXT,
    url TEXT NOT NULL, -- External link to full article
    tags TEXT[] DEFAULT '{}',
    publish_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for filtering and sorting
CREATE INDEX idx_news_category ON news(category);
CREATE INDEX idx_news_publish_date ON news(publish_date DESC);
CREATE INDEX idx_news_is_featured ON news(is_featured) WHERE is_featured = TRUE;

-- Full-text search: using generated column for immutability
ALTER TABLE news ADD COLUMN IF NOT EXISTS search_vector tsvector
    GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(title, '') || ' ' || coalesce(summary, ''))
    ) STORED;

CREATE INDEX idx_news_search ON news USING GIN (search_vector);

COMMENT ON TABLE news IS 'News articles for the home feed';

-- ============================================
-- 4. OPPORTUNITIES TABLE
-- ============================================

CREATE TABLE opportunities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type opportunity_type NOT NULL,
    title TEXT NOT NULL,
    company TEXT NOT NULL,
    company_logo_url TEXT,
    location TEXT NOT NULL,
    description TEXT,
    requirements TEXT[] DEFAULT '{}',
    salary INTEGER, -- Annual salary in USD (nullable for non-job types)
    salary_currency TEXT DEFAULT 'USD',
    deadline TIMESTAMPTZ,
    apply_url TEXT NOT NULL, -- External application link
    verified BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    date_posted TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for filtering and sorting
CREATE INDEX idx_opportunities_type ON opportunities(type);
CREATE INDEX idx_opportunities_location ON opportunities(location);
CREATE INDEX idx_opportunities_deadline ON opportunities(deadline ASC);
CREATE INDEX idx_opportunities_date_posted ON opportunities(date_posted DESC);
CREATE INDEX idx_opportunities_verified ON opportunities(verified) WHERE verified = TRUE;

-- Full-text search: using generated column for immutability
ALTER TABLE opportunities ADD COLUMN IF NOT EXISTS search_vector tsvector
    GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(title, '') || ' ' || coalesce(company, '') || ' ' || coalesce(location, ''))
    ) STORED;

CREATE INDEX idx_opportunities_search ON opportunities USING GIN (search_vector);

COMMENT ON TABLE opportunities IS 'Job, investment, scholarship, and tender listings';

-- ============================================
-- 5. EVENTS TABLE
-- ============================================

CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    type event_type NOT NULL,
    organizer TEXT NOT NULL,
    organizer_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    location TEXT NOT NULL,
    venue TEXT, -- Specific venue name
    date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ, -- For multi-day events
    image_url TEXT,
    capacity INTEGER,
    price DECIMAL(10, 2) DEFAULT 0, -- 0 = free event
    currency TEXT DEFAULT 'USD',
    registration_url TEXT, -- External registration link
    is_virtual BOOLEAN DEFAULT FALSE,
    virtual_link TEXT, -- Zoom/Meet link for virtual events
    tags TEXT[] DEFAULT '{}',
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for filtering and sorting
CREATE INDEX idx_events_type ON events(type);
CREATE INDEX idx_events_location ON events(location);
CREATE INDEX idx_events_date ON events(date ASC);
CREATE INDEX idx_events_organizer_id ON events(organizer_id);

-- Full-text search: using generated column for immutability
ALTER TABLE events ADD COLUMN IF NOT EXISTS search_vector tsvector
    GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(title, '') || ' ' || coalesce(description, '') || ' ' || coalesce(location, ''))
    ) STORED;

CREATE INDEX idx_events_search ON events USING GIN (search_vector);

COMMENT ON TABLE events IS 'Community and networking events';

-- ============================================
-- 6. EVENT RSVPs TABLE
-- ============================================

CREATE TABLE event_rsvps (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    status rsvp_status NOT NULL DEFAULT 'going',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),

    -- Each user can only RSVP once per event
    CONSTRAINT unique_event_rsvp UNIQUE (event_id, user_id)
);

-- Indexes
CREATE INDEX idx_event_rsvps_event_id ON event_rsvps(event_id);
CREATE INDEX idx_event_rsvps_user_id ON event_rsvps(user_id);

COMMENT ON TABLE event_rsvps IS 'Event RSVP tracking';

-- ============================================
-- 7. COMMUNITY POSTS TABLE
-- ============================================

CREATE TABLE community_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    author_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_pinned BOOLEAN DEFAULT FALSE,
    likes_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_community_posts_author_id ON community_posts(author_id);
CREATE INDEX idx_community_posts_created_at ON community_posts(created_at DESC);
CREATE INDEX idx_community_posts_is_pinned ON community_posts(is_pinned) WHERE is_pinned = TRUE;

-- Full-text search: using generated column for immutability
ALTER TABLE community_posts ADD COLUMN IF NOT EXISTS search_vector tsvector
    GENERATED ALWAYS AS (
        to_tsvector('english', coalesce(content, ''))
    ) STORED;

CREATE INDEX idx_community_posts_search ON community_posts USING GIN (search_vector);

COMMENT ON TABLE community_posts IS 'Community discussion posts';

-- ============================================
-- 8. BOOKMARKS TABLE
-- ============================================

CREATE TABLE bookmarks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    entity_type bookmark_entity_type NOT NULL,
    entity_id UUID NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),

    -- Each user can only bookmark an entity once
    CONSTRAINT unique_bookmark UNIQUE (user_id, entity_type, entity_id)
);

-- Indexes
CREATE INDEX idx_bookmarks_user_id ON bookmarks(user_id);
CREATE INDEX idx_bookmarks_entity ON bookmarks(entity_type, entity_id);

COMMENT ON TABLE bookmarks IS 'User bookmarks for various entities';

-- ============================================
-- 9. PAYMENT EVENTS TABLE
-- ============================================

CREATE TABLE payment_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    provider TEXT NOT NULL,
    event_type TEXT NOT NULL,
    provider_reference TEXT,
    status TEXT,
    amount DECIMAL(12, 2),
    currency TEXT,
    user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    subscription_plan subscription_plan,
    payload JSONB NOT NULL,
    received_at TIMESTAMPTZ DEFAULT NOW(),
    processed_at TIMESTAMPTZ
);

CREATE INDEX idx_payment_events_provider_reference ON payment_events(provider_reference);
CREATE INDEX idx_payment_events_user_id ON payment_events(user_id);

COMMENT ON TABLE payment_events IS 'Raw payment webhook events for audit and reconciliation';

-- ============================================
-- FUNCTIONS
-- ============================================

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Function to get RSVP count for an event
CREATE OR REPLACE FUNCTION get_event_rsvp_count(event_uuid UUID)
RETURNS INTEGER AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM event_rsvps
        WHERE event_id = event_uuid AND status = 'going'
    );
END;
$$ LANGUAGE plpgsql;

-- Function to create profile on user signup
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO profiles (id, name, email)
    VALUES (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'name', split_part(NEW.email, '@', 1)),
        NEW.email
    );

    -- Create free subscription for new user
    INSERT INTO subscriptions (user_id, plan, status)
    VALUES (NEW.id, 'free', 'active');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to activate trial subscription
CREATE OR REPLACE FUNCTION activate_trial(user_uuid UUID)
RETURNS subscriptions AS $$
DECLARE
    result subscriptions;
BEGIN
    UPDATE subscriptions
    SET
        plan = 'trial',
        status = 'active',
        start_date = NOW(),
        trial_ends_at = NOW() + INTERVAL '30 days',
        end_date = NOW() + INTERVAL '30 days',
        updated_at = NOW()
    WHERE user_id = user_uuid
    RETURNING * INTO result;

    RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- TRIGGERS
-- ============================================

-- Auto-update updated_at for all tables
CREATE TRIGGER update_profiles_updated_at
    BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_subscriptions_updated_at
    BEFORE UPDATE ON subscriptions
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_news_updated_at
    BEFORE UPDATE ON news
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_opportunities_updated_at
    BEFORE UPDATE ON opportunities
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_events_updated_at
    BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_event_rsvps_updated_at
    BEFORE UPDATE ON event_rsvps
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_community_posts_updated_at
    BEFORE UPDATE ON community_posts
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Trigger to create profile when user signs up
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- ============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================

-- Enable RLS on all tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE news ENABLE ROW LEVEL SECURITY;
ALTER TABLE opportunities ENABLE ROW LEVEL SECURITY;
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE event_rsvps ENABLE ROW LEVEL SECURITY;
ALTER TABLE community_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookmarks ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_events ENABLE ROW LEVEL SECURITY;

-- ============================================
-- PROFILES POLICIES
-- ============================================

-- Users can view their own profile
CREATE POLICY "Users can view own profile"
    ON profiles FOR SELECT
    USING (auth.uid() = id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile"
    ON profiles FOR UPDATE
    USING (auth.uid() = id)
    WITH CHECK (auth.uid() = id);

-- ============================================
-- SUBSCRIPTIONS POLICIES
-- ============================================

-- Users can view their own subscription
CREATE POLICY "Users can view own subscription"
    ON subscriptions FOR SELECT
    USING (auth.uid() = user_id);

-- ============================================
-- NEWS POLICIES
-- ============================================

-- Anyone can view news (public)
CREATE POLICY "News is publicly readable"
    ON news FOR SELECT
    TO authenticated
    USING (true);

-- ============================================
-- OPPORTUNITIES POLICIES
-- ============================================

-- Anyone can view opportunities (public)
CREATE POLICY "Opportunities are publicly readable"
    ON opportunities FOR SELECT
    TO authenticated
    USING (true);

-- ============================================
-- EVENTS POLICIES
-- ============================================

-- Anyone can view events (public)
CREATE POLICY "Events are publicly readable"
    ON events FOR SELECT
    TO authenticated
    USING (true);

-- ============================================
-- EVENT RSVPs POLICIES
-- ============================================

-- Users can view their own RSVPs
CREATE POLICY "Users can view own RSVPs"
    ON event_rsvps FOR SELECT
    USING (auth.uid() = user_id);

-- Users can create their own RSVPs
CREATE POLICY "Users can create own RSVPs"
    ON event_rsvps FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Users can update their own RSVPs
CREATE POLICY "Users can update own RSVPs"
    ON event_rsvps FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- Users can delete their own RSVPs
CREATE POLICY "Users can delete own RSVPs"
    ON event_rsvps FOR DELETE
    USING (auth.uid() = user_id);

-- ============================================
-- COMMUNITY POSTS POLICIES
-- ============================================

-- Anyone can view community posts
CREATE POLICY "Community posts are publicly readable"
    ON community_posts FOR SELECT
    TO authenticated
    USING (true);

-- Users can create their own posts
CREATE POLICY "Users can create own posts"
    ON community_posts FOR INSERT
    WITH CHECK (auth.uid() = author_id);

-- Users can update their own posts
CREATE POLICY "Users can update own posts"
    ON community_posts FOR UPDATE
    USING (auth.uid() = author_id)
    WITH CHECK (auth.uid() = author_id);

-- Users can delete their own posts
CREATE POLICY "Users can delete own posts"
    ON community_posts FOR DELETE
    USING (auth.uid() = author_id);

-- ============================================
-- BOOKMARKS POLICIES
-- ============================================

-- Users can view their own bookmarks
CREATE POLICY "Users can view own bookmarks"
    ON bookmarks FOR SELECT
    USING (auth.uid() = user_id);

-- Users can create their own bookmarks
CREATE POLICY "Users can create own bookmarks"
    ON bookmarks FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Users can delete their own bookmarks
CREATE POLICY "Users can delete own bookmarks"
    ON bookmarks FOR DELETE
    USING (auth.uid() = user_id);

-- ============================================
-- VIEWS FOR API RESPONSES
-- ============================================

-- View for events with RSVP count
CREATE OR REPLACE VIEW events_with_rsvp_count AS
SELECT
    e.*,
    COALESCE(r.rsvp_count, 0) AS rsvp_count
FROM events e
LEFT JOIN (
    SELECT event_id, COUNT(*) AS rsvp_count
    FROM event_rsvps
    WHERE status = 'going'
    GROUP BY event_id
) r ON e.id = r.event_id;

-- View for community posts with author info
CREATE OR REPLACE VIEW community_posts_with_author AS
SELECT
    cp.*,
    p.name AS author_name,
    p.avatar_url AS author_avatar_url
FROM community_posts cp
JOIN profiles p ON cp.author_id = p.id;

-- ============================================
-- SAMPLE DATA (Optional - Remove in production)
-- ============================================

-- Uncomment to insert sample data for testing

/*
-- Sample news
INSERT INTO news (title, source, category, summary, url, publish_date, is_featured) VALUES
('Diaspora Remittances Hit Record High in 2025', 'The New Times', 'Economy', 'Rwanda received a record $500 million in diaspora remittances in 2025, marking a 15% increase from the previous year.', 'https://newtimes.co.rw/article/123', NOW() - INTERVAL '1 day', true),
('New Investment Opportunities in Kigali Innovation City', 'The New Times', 'Investment', 'Kigali Innovation City announces new investment packages targeting diaspora entrepreneurs.', 'https://rwandatoday.rw/article/456', NOW() - INTERVAL '2 days', false),
('Annual Diaspora Conference Announced for December', 'The New Times', 'Events', 'The government announces the 2025 Rwanda Diaspora Conference to be held in Kigali.', 'https://igihe.com/article/789', NOW() - INTERVAL '3 days', true);

-- Sample opportunities
INSERT INTO opportunities (type, title, company, location, description, salary, deadline, apply_url, verified, is_featured) VALUES
('job', 'Senior Software Engineer', 'PayRwanda Ltd', 'Kigali, Rwanda', 'We are looking for an experienced software engineer to join our fintech team.', 55000, NOW() + INTERVAL '30 days', 'https://payrwanda.com/careers/sse', true, true),
('investment', 'AgriTech Startup - Series A', 'Rwanda AgriTech Hub', 'Kigali, Rwanda', 'Investment opportunity in a promising agricultural technology startup.', NULL, NOW() + INTERVAL '60 days', 'https://agrihub.rw/invest', true, false),
('scholarship', 'Carnegie Mellon Africa Scholarship', 'CMU Africa', 'Kigali, Rwanda', 'Full scholarship for Masters in Information Technology at CMU Africa.', NULL, NOW() + INTERVAL '45 days', 'https://cmu.africa/scholarship', true, true);

-- Sample events
INSERT INTO events (title, description, type, organizer, location, date, capacity, is_featured) VALUES
('Rwanda Connect Toronto Networking Night', 'Join fellow Rwandan professionals in Toronto for an evening of networking and knowledge sharing.', 'networking', 'Rwanda Connect', 'Toronto, Canada', NOW() + INTERVAL '14 days', 100, true),
('Diaspora Investment Workshop', 'Learn about investment opportunities in Rwanda real estate and startups.', 'workshop', 'RDB Diaspora Office', 'Virtual', NOW() + INTERVAL '7 days', 500, true),
('Kigali Tech Summit 2025', 'Annual technology conference bringing together innovators from Africa and the diaspora.', 'conference', 'Rwanda ICT Chamber', 'Kigali, Rwanda', NOW() + INTERVAL '60 days', 1000, false);
*/

-- ============================================
-- GRANT PERMISSIONS
-- ============================================

-- Grant usage on schema
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO anon;

-- Grant select on views
GRANT SELECT ON events_with_rsvp_count TO authenticated;
GRANT SELECT ON community_posts_with_author TO authenticated;
