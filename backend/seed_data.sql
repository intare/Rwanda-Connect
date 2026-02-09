-- ============================================
-- Rwanda Connect Sample Data
-- ============================================
-- Run this AFTER schema.sql
-- This creates realistic test data for development
-- ============================================

-- ============================================
-- NEWS (15 articles)
-- ============================================

INSERT INTO news (title, source, category, summary, url, publish_date, is_featured) VALUES
-- Economy
('Diaspora Remittances Hit Record $500M in 2025', 'The New Times', 'Economy', 'Rwanda received a record $500 million in diaspora remittances in 2025, marking a 15% increase from the previous year. The Central Bank attributes this growth to improved digital transfer channels.', 'https://newtimes.co.rw/economy/remittances-record', NOW() - INTERVAL '1 day', true),

('Rwanda GDP Growth Projected at 8.5% for 2026', 'The New Times', 'Economy', 'The International Monetary Fund projects Rwanda''s economy to grow by 8.5% in 2026, driven by services, tourism, and technology sectors.', 'https://newtimes.co.rw/economy/gdp-growth', NOW() - INTERVAL '3 days', false),

('New Tax Incentives for Diaspora Investors Announced', 'Rwanda Today', 'Economy', 'The Rwanda Development Board unveils new tax incentives specifically designed to attract diaspora investment in key sectors including manufacturing and ICT.', 'https://rwandatoday.rw/economy/tax-incentives', NOW() - INTERVAL '5 days', true),

-- Investment
('Kigali Innovation City Opens Phase 2 for Investment', 'Igihe', 'Investment', 'Kigali Innovation City announces Phase 2 development with $200M in investment opportunities for tech companies and diaspora entrepreneurs.', 'https://igihe.com/investment/kic-phase2', NOW() - INTERVAL '2 days', true),

('Real Estate Boom: New Developments in Kigali Heights', 'The New Times', 'Investment', 'Premium residential and commercial developments in Kigali Heights attract significant diaspora interest with flexible payment plans.', 'https://newtimes.co.rw/investment/kigali-heights', NOW() - INTERVAL '4 days', false),

('AgriTech Sector Attracts $50M in New Investments', 'Rwanda Today', 'Investment', 'Rwanda''s agricultural technology sector sees surge in investment as startups revolutionize farming practices across the country.', 'https://rwandatoday.rw/investment/agritech', NOW() - INTERVAL '7 days', false),

-- Events
('Annual Diaspora Conference Set for December 2025', 'The New Times', 'Events', 'The government announces the Rwanda Diaspora Global Convention 2025, bringing together Rwandans from over 50 countries to discuss investment and development.', 'https://newtimes.co.rw/events/diaspora-conference', NOW() - INTERVAL '1 day', true),

('Rwanda Day Boston Announced for March 2026', 'Igihe', 'Events', 'Rwanda Day returns to Boston in March 2026, featuring cultural celebrations, business networking, and community building activities.', 'https://igihe.com/events/rwanda-day-boston', NOW() - INTERVAL '6 days', false),

-- Business
('BK Group Launches Diaspora Banking Package', 'The New Times', 'Business', 'Bank of Kigali introduces comprehensive banking solutions for the diaspora including USD accounts, international transfers, and mortgage products.', 'https://newtimes.co.rw/business/bk-diaspora', NOW() - INTERVAL '2 days', true),

('MTN Rwanda Partners with M-Pesa for Cross-Border Payments', 'Rwanda Today', 'Business', 'New partnership enables seamless mobile money transfers between diaspora and families in Rwanda with reduced fees.', 'https://rwandatoday.rw/business/mtn-mpesa', NOW() - INTERVAL '8 days', false),

('Zipline Expands Medical Drone Delivery Network', 'The New Times', 'Business', 'Zipline Rwanda expands its drone delivery network to cover 100% of the country, delivering medical supplies to remote areas.', 'https://newtimes.co.rw/business/zipline-expansion', NOW() - INTERVAL '10 days', false),

-- Policy
('Rwanda Introduces Digital Nomad Visa', 'Igihe', 'Policy', 'Rwanda launches a new digital nomad visa program allowing remote workers to live and work in the country for up to 2 years.', 'https://igihe.com/policy/digital-nomad-visa', NOW() - INTERVAL '3 days', true),

('New Property Ownership Laws Benefit Diaspora', 'The New Times', 'Policy', 'Updated land registration laws simplify property ownership for Rwandans living abroad, with digital verification systems.', 'https://newtimes.co.rw/policy/property-laws', NOW() - INTERVAL '9 days', false),

('Dual Citizenship Application Process Streamlined', 'Rwanda Today', 'Policy', 'Immigration announces simplified online process for diaspora dual citizenship applications with 30-day processing guarantee.', 'https://rwandatoday.rw/policy/dual-citizenship', NOW() - INTERVAL '12 days', false),

('Government Launches One-Stop Diaspora Services Portal', 'The New Times', 'Policy', 'New online portal provides diaspora with single access point for all government services including business registration and document authentication.', 'https://newtimes.co.rw/policy/diaspora-portal', NOW() - INTERVAL '15 days', true);

-- ============================================
-- OPPORTUNITIES (20 listings)
-- ============================================

INSERT INTO opportunities (type, title, company, location, description, requirements, salary, salary_currency, deadline, apply_url, verified, is_featured, date_posted) VALUES

-- Jobs
('job', 'Senior Software Engineer', 'PayRwanda Ltd', 'Kigali, Rwanda',
'Join our fintech team building the next generation of payment solutions for Rwanda and East Africa. You will lead development of our mobile banking platform serving millions of users.',
ARRAY['5+ years software development experience', 'Strong in Python, Node.js, or Go', 'Experience with microservices architecture', 'Fintech experience preferred'],
55000, 'USD', NOW() + INTERVAL '30 days', 'https://payrwanda.com/careers/senior-engineer', true, true, NOW() - INTERVAL '5 days'),

('job', 'Product Manager - Mobile Apps', 'Irembo', 'Kigali, Rwanda',
'Lead product strategy for Rwanda''s largest e-government platform. Drive user experience improvements serving millions of citizens.',
ARRAY['3+ years product management experience', 'Experience with mobile applications', 'Strong analytical and communication skills', 'French or Kinyarwanda is a plus'],
48000, 'USD', NOW() + INTERVAL '21 days', 'https://irembo.gov.rw/careers/pm', true, true, NOW() - INTERVAL '3 days'),

('job', 'Data Scientist', 'Bank of Kigali', 'Kigali, Rwanda',
'Build ML models to improve credit scoring, fraud detection, and customer insights for Rwanda''s largest bank.',
ARRAY['Masters in Data Science, Statistics, or related field', 'Proficiency in Python, R, and SQL', '2+ years experience in financial services', 'Experience with ML frameworks'],
52000, 'USD', NOW() + INTERVAL '45 days', 'https://bk.rw/careers/data-scientist', true, false, NOW() - INTERVAL '7 days'),

('job', 'Marketing Director', 'Visit Rwanda', 'Kigali, Rwanda',
'Lead global marketing campaigns promoting Rwanda as a premier tourist and business destination.',
ARRAY['10+ years marketing experience', 'Experience in tourism or hospitality industry', 'Proven track record of successful campaigns', 'Strong leadership skills'],
75000, 'USD', NOW() + INTERVAL '60 days', 'https://visitrwanda.com/careers/marketing-director', true, false, NOW() - INTERVAL '10 days'),

('job', 'Full Stack Developer', 'Andela Rwanda', 'Kigali, Rwanda (Hybrid)',
'Build scalable web applications for global clients. Work with cutting-edge technologies in a collaborative environment.',
ARRAY['3+ years full stack development', 'React, Node.js, PostgreSQL expertise', 'Experience with cloud platforms (AWS/GCP)', 'Strong problem-solving skills'],
42000, 'USD', NOW() + INTERVAL '14 days', 'https://andela.com/careers/fullstack-rw', true, true, NOW() - INTERVAL '2 days'),

('job', 'Healthcare Administrator', 'King Faisal Hospital', 'Kigali, Rwanda',
'Oversee daily operations and strategic planning for East Africa''s leading referral hospital.',
ARRAY['MBA or MHA degree', '7+ years healthcare administration', 'Experience with hospital management systems', 'Fluent in English'],
60000, 'USD', NOW() + INTERVAL '35 days', 'https://kfh.rw/careers/admin', true, false, NOW() - INTERVAL '8 days'),

('job', 'DevOps Engineer', 'AC Group', 'Kigali, Rwanda (Remote)',
'Build and maintain cloud infrastructure for pan-African tech solutions.',
ARRAY['4+ years DevOps experience', 'Kubernetes, Docker, Terraform expertise', 'AWS or GCP certification preferred', 'CI/CD pipeline experience'],
50000, 'USD', NOW() + INTERVAL '28 days', 'https://acgroup.rw/careers/devops', true, false, NOW() - INTERVAL '6 days'),

-- Investments
('investment', 'AgriTech Startup - Series A', 'Rwanda AgriTech Hub', 'Kigali, Rwanda',
'Investment opportunity in a promising agricultural technology startup revolutionizing smallholder farming with IoT and data analytics. Targeting $5M raise.',
ARRAY['Minimum investment: $50,000', 'Projected ROI: 25% over 5 years', 'Board observer seat for $250K+'],
NULL, 'USD', NOW() + INTERVAL '90 days', 'https://agrihub.rw/invest/series-a', true, true, NOW() - INTERVAL '10 days'),

('investment', 'Kigali Heights Commercial Complex', 'Prime Real Estate Rwanda', 'Kigali, Rwanda',
'Premium commercial real estate investment in Kigali''s business district. Mixed-use development with retail, office, and residential units.',
ARRAY['Minimum investment: $100,000', 'Expected rental yield: 12% annually', 'Flexible payment plans available'],
NULL, 'USD', NOW() + INTERVAL '120 days', 'https://primerealestate.rw/kigali-heights', true, true, NOW() - INTERVAL '15 days'),

('investment', 'Solar Energy Fund', 'Rwanda Green Energy', 'Nationwide, Rwanda',
'Join the renewable energy revolution. Fund supports solar installations across rural Rwanda with guaranteed government contracts.',
ARRAY['Minimum investment: $25,000', 'Government-backed power purchase agreements', '10-year investment horizon'],
NULL, 'USD', NOW() + INTERVAL '60 days', 'https://greenenergy.rw/solar-fund', true, false, NOW() - INTERVAL '20 days'),

('investment', 'Tourism Lodge Development', 'Akagera Ventures', 'Akagera National Park, Rwanda',
'Eco-lodge development in partnership with African Parks. Premium safari experience targeting high-end tourists.',
ARRAY['Minimum investment: $200,000', 'Partnership with African Parks', 'Projected 18% annual returns'],
NULL, 'USD', NOW() + INTERVAL '75 days', 'https://akageraventures.rw/lodge-investment', true, false, NOW() - INTERVAL '12 days'),

-- Scholarships
('scholarship', 'Carnegie Mellon Africa Full Scholarship', 'CMU Africa', 'Kigali, Rwanda',
'Full scholarship for Masters in Information Technology at Carnegie Mellon University Africa. Covers tuition, accommodation, and living expenses.',
ARRAY['Bachelor''s degree in relevant field', 'Minimum GPA: 3.0', 'Strong quantitative background', 'Diaspora applicants encouraged'],
NULL, 'USD', NOW() + INTERVAL '45 days', 'https://cmu.africa/scholarship', true, true, NOW() - INTERVAL '5 days'),

('scholarship', 'Rwanda Government STEM Scholarship', 'Ministry of Education', 'Various, Rwanda',
'Government-funded scholarship for diaspora youth to study STEM subjects at Rwandan universities.',
ARRAY['Age 18-25', 'Rwandan heritage', 'High school diploma with strong math/science grades', 'Commitment to work in Rwanda for 3 years'],
NULL, 'USD', NOW() + INTERVAL '60 days', 'https://mineduc.gov.rw/diaspora-scholarship', true, false, NOW() - INTERVAL '8 days'),

('scholarship', 'African Leadership University Merit Award', 'ALU Rwanda', 'Kigali, Rwanda',
'Merit-based scholarship covering 50-100% of tuition for undergraduate programs in Business, Engineering, or Computer Science.',
ARRAY['Strong academic record', 'Leadership experience', 'Community involvement', 'Essay required'],
NULL, 'USD', NOW() + INTERVAL '30 days', 'https://alueducation.com/scholarship', true, false, NOW() - INTERVAL '3 days'),

('scholarship', 'Mastercard Foundation Scholars Program', 'University of Rwanda', 'Kigali, Rwanda',
'Comprehensive scholarship for academically talented students from economically disadvantaged backgrounds.',
ARRAY['Financial need demonstrated', 'Academic excellence', 'Leadership potential', 'Community service orientation'],
NULL, 'USD', NOW() + INTERVAL '55 days', 'https://ur.ac.rw/mastercard-scholars', true, true, NOW() - INTERVAL '7 days'),

-- Tenders
('tender', 'ICT Infrastructure Development', 'Rwanda Information Society Authority', 'Nationwide, Rwanda',
'Tender for nationwide 5G network infrastructure development. Multi-year contract valued at $50M.',
ARRAY['Registered telecom infrastructure company', 'Previous experience in East Africa', 'Financial capacity demonstration required', 'Technical proposal required'],
NULL, 'USD', NOW() + INTERVAL '40 days', 'https://risa.gov.rw/tenders/5g-infrastructure', true, true, NOW() - INTERVAL '4 days'),

('tender', 'Hospital Equipment Supply', 'Rwanda Biomedical Center', 'Kigali, Rwanda',
'Supply of medical imaging equipment for district hospitals. Contract value: $8M.',
ARRAY['ISO certified medical equipment supplier', 'After-sales service capability in Rwanda', 'Training provision required'],
NULL, 'USD', NOW() + INTERVAL '25 days', 'https://rbc.gov.rw/tenders/medical-equipment', true, false, NOW() - INTERVAL '6 days'),

('tender', 'School Construction Project', 'Ministry of Education', 'Eastern Province, Rwanda',
'Construction of 10 secondary schools in Eastern Province. Total budget: $15M.',
ARRAY['Licensed construction company', 'Previous education sector experience', 'Local partnership required for foreign companies'],
NULL, 'USD', NOW() + INTERVAL '50 days', 'https://mineduc.gov.rw/tenders/school-construction', true, false, NOW() - INTERVAL '9 days'),

('tender', 'Agricultural Export Logistics', 'NAEB', 'Kigali, Rwanda',
'Logistics and cold chain management for horticultural exports. 3-year renewable contract.',
ARRAY['Cold chain logistics experience', 'HACCP certification', 'Fleet of refrigerated vehicles', 'Experience with perishable goods'],
NULL, 'USD', NOW() + INTERVAL '35 days', 'https://naeb.gov.rw/tenders/export-logistics', true, false, NOW() - INTERVAL '11 days');

-- ============================================
-- EVENTS (15 events)
-- ============================================

INSERT INTO events (title, description, type, organizer, location, venue, date, end_date, capacity, price, currency, is_virtual, is_featured) VALUES

-- Networking Events
('Rwanda Connect Toronto Networking Night',
'Join fellow Rwandan professionals in Toronto for an evening of networking, knowledge sharing, and community building. Light refreshments provided.',
'networking', 'Rwanda Connect Toronto', 'Toronto, Canada', 'The Globe and Mail Centre',
NOW() + INTERVAL '14 days', NULL, 100, 25.00, 'CAD', false, true),

('Diaspora Professionals Mixer - London',
'Monthly networking event for Rwandan professionals in London. Great opportunity to connect with others in finance, tech, and healthcare sectors.',
'networking', 'Rwanda UK Network', 'London, United Kingdom', 'WeWork Moorgate',
NOW() + INTERVAL '21 days', NULL, 75, 15.00, 'GBP', false, false),

('Kigali Tech Meetup',
'Weekly gathering of tech enthusiasts, developers, and entrepreneurs. This week: AI and Machine Learning in Rwanda.',
'networking', 'Kigali Tech Community', 'Kigali, Rwanda', 'The Office Kigali',
NOW() + INTERVAL '5 days', NULL, 50, 0, 'RWF', false, false),

('Women in Business Rwanda Chapter',
'Networking breakfast for women entrepreneurs and professionals. Featuring speaker from Bank of Kigali on access to finance.',
'networking', 'Women in Business Africa', 'Kigali, Rwanda', 'Marriott Kigali',
NOW() + INTERVAL '10 days', NULL, 60, 15000, 'RWF', false, true),

-- Seminars
('Investing in Rwanda Real Estate - Webinar',
'Comprehensive guide to property investment in Rwanda for diaspora. Topics include legal framework, financing options, and market trends.',
'seminar', 'RDB Diaspora Desk', 'Virtual', 'Zoom',
NOW() + INTERVAL '7 days', NULL, 500, 0, 'USD', true, true),

('Tax Planning for Diaspora Investors',
'Learn about tax implications and benefits for diaspora investing in Rwanda. Presented by RRA and PwC Rwanda.',
'seminar', 'Rwanda Revenue Authority', 'Virtual', 'Microsoft Teams',
NOW() + INTERVAL '12 days', NULL, 300, 0, 'USD', true, false),

('Starting a Business in Rwanda',
'Step-by-step guide to company registration, licensing, and compliance. Interactive session with RDB business registration team.',
'seminar', 'Rwanda Development Board', 'Kigali, Rwanda', 'RDB Headquarters',
NOW() + INTERVAL '18 days', NULL, 100, 0, 'USD', false, false),

-- Workshops
('Diaspora Investment Workshop',
'Hands-on workshop covering investment opportunities in agriculture, real estate, and technology. Includes site visits.',
'workshop', 'RDB Diaspora Office', 'Kigali, Rwanda', 'Kigali Convention Centre',
NOW() + INTERVAL '30 days', NOW() + INTERVAL '31 days', 150, 50.00, 'USD', false, true),

('Tech Entrepreneurship Bootcamp',
'Intensive 2-day bootcamp for aspiring tech entrepreneurs. Learn product development, fundraising, and scaling strategies.',
'workshop', 'Norrsken Kigali', 'Kigali, Rwanda', 'Norrsken House Kigali',
NOW() + INTERVAL '25 days', NOW() + INTERVAL '26 days', 40, 100.00, 'USD', false, true),

('Grant Writing Workshop',
'Learn how to write successful grant proposals for NGOs and social enterprises operating in Rwanda.',
'workshop', 'Rwanda Civil Society Platform', 'Kigali, Rwanda', 'Lemigo Hotel',
NOW() + INTERVAL '20 days', NULL, 35, 25000, 'RWF', false, false),

-- Conferences
('Kigali Tech Summit 2026',
'Annual technology conference bringing together innovators from Africa and the diaspora. Keynotes, panels, and startup showcases.',
'conference', 'Rwanda ICT Chamber', 'Kigali, Rwanda', 'Kigali Convention Centre',
NOW() + INTERVAL '60 days', NOW() + INTERVAL '62 days', 1000, 150.00, 'USD', false, true),

('Rwanda Diaspora Global Convention',
'The flagship annual gathering of Rwandans from around the world. Government ministers, business leaders, and community discussions.',
'conference', 'MINAFFET', 'Kigali, Rwanda', 'Kigali Convention Centre',
NOW() + INTERVAL '90 days', NOW() + INTERVAL '92 days', 2000, 0, 'USD', false, true),

('East Africa Investment Forum',
'Regional investment conference featuring opportunities across Rwanda, Kenya, Tanzania, and Uganda.',
'conference', 'East African Business Council', 'Kigali, Rwanda', 'Radisson Blu Kigali',
NOW() + INTERVAL '45 days', NOW() + INTERVAL '46 days', 500, 200.00, 'USD', false, false),

('Africa Healthcare Summit',
'Conference on healthcare innovation and investment opportunities in Africa. Focus on digital health and medical tourism.',
'conference', 'Africa Health Business', 'Kigali, Rwanda', 'Marriott Kigali',
NOW() + INTERVAL '75 days', NOW() + INTERVAL '76 days', 400, 175.00, 'USD', false, false),

('Rwanda Day Brussels 2026',
'Cultural celebration and community gathering for Rwandans in Belgium and Europe. Music, food, and networking.',
'conference', 'Rwanda Embassy Belgium', 'Brussels, Belgium', 'Brussels Expo',
NOW() + INTERVAL '120 days', NULL, 3000, 20.00, 'EUR', false, true);

-- ============================================
-- VERIFICATION
-- ============================================

SELECT 'news' as table_name, COUNT(*) as row_count FROM news
UNION ALL
SELECT 'opportunities', COUNT(*) FROM opportunities
UNION ALL
SELECT 'events', COUNT(*) FROM events;
