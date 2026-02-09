-- ============================================
-- Rwanda Connect Database Schema for PostgreSQL
-- ============================================
-- Standalone PostgreSQL schema (no Supabase dependencies)
-- Compatible with Payload CMS backend
-- ============================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- ENUM TYPES
-- ============================================

-- Subscription plans
DO $$ BEGIN
    CREATE TYPE subscription_plan AS ENUM ('free', 'trial', 'monthly', 'yearly');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Subscription status
DO $$ BEGIN
    CREATE TYPE subscription_status AS ENUM ('active', 'expired', 'cancelled');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Opportunity types
DO $$ BEGIN
    CREATE TYPE opportunity_type AS ENUM ('job', 'investment', 'scholarship', 'tender');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Event types
DO $$ BEGIN
    CREATE TYPE event_type AS ENUM ('networking', 'seminar', 'workshop', 'conference');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- News categories
DO $$ BEGIN
    CREATE TYPE news_category AS ENUM ('Economy', 'Investment', 'Events', 'Business', 'Policy');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- RSVP status
DO $$ BEGIN
    CREATE TYPE rsvp_status AS ENUM ('going', 'interested', 'not_going');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- Bookmark entity types
DO $$ BEGIN
    CREATE TYPE bookmark_entity_type AS ENUM ('opportunity', 'event', 'news', 'post');
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ============================================
-- 1. PROFILES TABLE (standalone user profiles)
-- ============================================

CREATE TABLE IF NOT EXISTS profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    avatar_url TEXT,
    location TEXT,
    interests TEXT[] DEFAULT '{}',
    onboarding_completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_profiles_email ON profiles(email);

COMMENT ON TABLE profiles IS 'User profiles for Rwanda Connect';

-- ============================================
-- 2. SUBSCRIPTIONS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    plan subscription_plan NOT NULL DEFAULT 'free',
    status subscription_status NOT NULL DEFAULT 'active',
    billing_provider TEXT,
    external_subscription_id TEXT,
    start_date TIMESTAMPTZ DEFAULT NOW(),
    end_date TIMESTAMPTZ,
    trial_ends_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_active_subscription UNIQUE (user_id)
);

CREATE INDEX IF NOT EXISTS idx_subscriptions_user_id ON subscriptions(user_id);
CREATE INDEX IF NOT EXISTS idx_subscriptions_status ON subscriptions(status);

COMMENT ON TABLE subscriptions IS 'User subscription and billing information';

-- ============================================
-- 3. NEWS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS news (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    source TEXT NOT NULL,
    category news_category NOT NULL,
    summary TEXT NOT NULL,
    content TEXT,
    image_url TEXT,
    url TEXT NOT NULL,
    tags TEXT[] DEFAULT '{}',
    publish_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_news_category ON news(category);
CREATE INDEX IF NOT EXISTS idx_news_publish_date ON news(publish_date DESC);
CREATE INDEX IF NOT EXISTS idx_news_is_featured ON news(is_featured) WHERE is_featured = TRUE;

COMMENT ON TABLE news IS 'News articles for the home feed';

-- ============================================
-- 4. OPPORTUNITIES TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS opportunities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    type opportunity_type NOT NULL,
    title TEXT NOT NULL,
    company TEXT NOT NULL,
    company_logo_url TEXT,
    location TEXT NOT NULL,
    description TEXT,
    requirements TEXT[] DEFAULT '{}',
    salary INTEGER,
    salary_currency TEXT DEFAULT 'USD',
    deadline TIMESTAMPTZ,
    apply_url TEXT NOT NULL,
    verified BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    date_posted TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_opportunities_type ON opportunities(type);
CREATE INDEX IF NOT EXISTS idx_opportunities_location ON opportunities(location);
CREATE INDEX IF NOT EXISTS idx_opportunities_deadline ON opportunities(deadline ASC);
CREATE INDEX IF NOT EXISTS idx_opportunities_date_posted ON opportunities(date_posted DESC);
CREATE INDEX IF NOT EXISTS idx_opportunities_verified ON opportunities(verified) WHERE verified = TRUE;

COMMENT ON TABLE opportunities IS 'Job, investment, scholarship, and tender listings';

-- ============================================
-- 5. EVENTS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title TEXT NOT NULL,
    description TEXT,
    type event_type NOT NULL,
    organizer TEXT NOT NULL,
    organizer_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
    location TEXT NOT NULL,
    venue TEXT,
    date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ,
    image_url TEXT,
    capacity INTEGER,
    price DECIMAL(10, 2) DEFAULT 0,
    currency TEXT DEFAULT 'USD',
    registration_url TEXT,
    is_virtual BOOLEAN DEFAULT FALSE,
    virtual_link TEXT,
    tags TEXT[] DEFAULT '{}',
    is_featured BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_events_type ON events(type);
CREATE INDEX IF NOT EXISTS idx_events_location ON events(location);
CREATE INDEX IF NOT EXISTS idx_events_date ON events(date ASC);
CREATE INDEX IF NOT EXISTS idx_events_organizer_id ON events(organizer_id);

COMMENT ON TABLE events IS 'Community and networking events';

-- ============================================
-- 6. EVENT RSVPs TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS event_rsvps (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_id UUID NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    status rsvp_status NOT NULL DEFAULT 'going',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_event_rsvp UNIQUE (event_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_event_rsvps_event_id ON event_rsvps(event_id);
CREATE INDEX IF NOT EXISTS idx_event_rsvps_user_id ON event_rsvps(user_id);

COMMENT ON TABLE event_rsvps IS 'Event RSVP tracking';

-- ============================================
-- 7. COMMUNITY POSTS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS community_posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    author_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_pinned BOOLEAN DEFAULT FALSE,
    likes_count INTEGER DEFAULT 0,
    comments_count INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_community_posts_author_id ON community_posts(author_id);
CREATE INDEX IF NOT EXISTS idx_community_posts_created_at ON community_posts(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_community_posts_is_pinned ON community_posts(is_pinned) WHERE is_pinned = TRUE;

COMMENT ON TABLE community_posts IS 'Community discussion posts';

-- ============================================
-- 8. BOOKMARKS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS bookmarks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    entity_type bookmark_entity_type NOT NULL,
    entity_id UUID NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_bookmark UNIQUE (user_id, entity_type, entity_id)
);

CREATE INDEX IF NOT EXISTS idx_bookmarks_user_id ON bookmarks(user_id);
CREATE INDEX IF NOT EXISTS idx_bookmarks_entity ON bookmarks(entity_type, entity_id);

COMMENT ON TABLE bookmarks IS 'User bookmarks for various entities';

-- ============================================
-- 9. PAYMENT EVENTS TABLE
-- ============================================

CREATE TABLE IF NOT EXISTS payment_events (
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

CREATE INDEX IF NOT EXISTS idx_payment_events_provider_reference ON payment_events(provider_reference);
CREATE INDEX IF NOT EXISTS idx_payment_events_user_id ON payment_events(user_id);

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
$$ LANGUAGE plpgsql;

-- ============================================
-- TRIGGERS
-- ============================================

-- Drop existing triggers if they exist (for idempotency)
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
DROP TRIGGER IF EXISTS update_subscriptions_updated_at ON subscriptions;
DROP TRIGGER IF EXISTS update_news_updated_at ON news;
DROP TRIGGER IF EXISTS update_opportunities_updated_at ON opportunities;
DROP TRIGGER IF EXISTS update_events_updated_at ON events;
DROP TRIGGER IF EXISTS update_event_rsvps_updated_at ON event_rsvps;
DROP TRIGGER IF EXISTS update_community_posts_updated_at ON community_posts;

-- Create triggers for auto-updating updated_at
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
-- FULL-TEXT SEARCH INDEXES
-- ============================================

-- Add search vectors as generated columns
DO $$
BEGIN
    -- News search vector
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'news' AND column_name = 'search_vector') THEN
        ALTER TABLE news ADD COLUMN search_vector tsvector
            GENERATED ALWAYS AS (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(summary, ''))) STORED;
    END IF;

    -- Opportunities search vector
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'opportunities' AND column_name = 'search_vector') THEN
        ALTER TABLE opportunities ADD COLUMN search_vector tsvector
            GENERATED ALWAYS AS (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(company, '') || ' ' || coalesce(location, ''))) STORED;
    END IF;

    -- Events search vector
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'events' AND column_name = 'search_vector') THEN
        ALTER TABLE events ADD COLUMN search_vector tsvector
            GENERATED ALWAYS AS (to_tsvector('english', coalesce(title, '') || ' ' || coalesce(description, '') || ' ' || coalesce(location, ''))) STORED;
    END IF;

    -- Community posts search vector
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'community_posts' AND column_name = 'search_vector') THEN
        ALTER TABLE community_posts ADD COLUMN search_vector tsvector
            GENERATED ALWAYS AS (to_tsvector('english', coalesce(content, ''))) STORED;
    END IF;
END $$;

-- Create GIN indexes for full-text search
CREATE INDEX IF NOT EXISTS idx_news_search ON news USING GIN (search_vector);
CREATE INDEX IF NOT EXISTS idx_opportunities_search ON opportunities USING GIN (search_vector);
CREATE INDEX IF NOT EXISTS idx_events_search ON events USING GIN (search_vector);
CREATE INDEX IF NOT EXISTS idx_community_posts_search ON community_posts USING GIN (search_vector);

-- ============================================
-- DONE
-- ============================================
SELECT 'Rwanda Connect schema applied successfully!' AS status;
