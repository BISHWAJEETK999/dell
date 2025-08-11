-- Initial database schema for TTravel Hospitality

-- Users table for admin authentication
CREATE TABLE IF NOT EXISTS "users" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "username" varchar(255) NOT NULL UNIQUE,
    "password" varchar(255) NOT NULL,
    "created_at" timestamp DEFAULT now()
);

-- Content management table for dynamic website content
CREATE TABLE IF NOT EXISTS "content" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "key" varchar(255) NOT NULL UNIQUE,
    "value" text NOT NULL,
    "updated_at" timestamp DEFAULT now()
);

-- Destinations table for domestic and international packages
CREATE TABLE IF NOT EXISTS "destinations" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" varchar(255) NOT NULL,
    "description" text NOT NULL,
    "image_url" varchar(500) NOT NULL,
    "location" varchar(255) NOT NULL,
    "price" decimal(10,2) NOT NULL,
    "duration" varchar(100) NOT NULL,
    "category" varchar(50) NOT NULL CHECK ("category" IN ('domestic', 'international')),
    "features" text[] DEFAULT '{}',
    "created_at" timestamp DEFAULT now()
);

-- Packages table for travel packages
CREATE TABLE IF NOT EXISTS "packages" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "title" varchar(255) NOT NULL,
    "description" text NOT NULL,
    "image_url" varchar(500) NOT NULL,
    "price" decimal(10,2) NOT NULL,
    "duration" varchar(100) NOT NULL,
    "location" varchar(255) NOT NULL,
    "features" text[] DEFAULT '{}',
    "buy_now_url" varchar(500),
    "created_at" timestamp DEFAULT now()
);

-- Contact submissions table
CREATE TABLE IF NOT EXISTS "contact_submissions" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "first_name" varchar(255) NOT NULL,
    "last_name" varchar(255) NOT NULL,
    "email" varchar(255) NOT NULL,
    "phone" varchar(20) NOT NULL,
    "message" text NOT NULL,
    "responded" boolean DEFAULT false,
    "created_at" timestamp DEFAULT now()
);

-- Newsletter subscriptions table
CREATE TABLE IF NOT EXISTS "newsletter_subscriptions" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "email" varchar(255) NOT NULL UNIQUE,
    "active" boolean DEFAULT true,
    "created_at" timestamp DEFAULT now()
);

-- Gallery images table
CREATE TABLE IF NOT EXISTS "gallery_images" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "url" varchar(500),
    "base64_data" text,
    "filename" varchar(255),
    "approved" boolean DEFAULT false,
    "uploaded_at" timestamp DEFAULT now()
);

-- Insert default admin user (password: 8709612003)
INSERT INTO "users" ("username", "password") VALUES ('admin', '8709612003')
ON CONFLICT (username) DO NOTHING;

-- Insert default content
INSERT INTO "content" ("key", "value") VALUES 
    ('site.name', 'TTravel Hospitality'),
    ('hero.title', 'Discover Amazing Travel Experiences'),
    ('hero.subtitle', 'Your gateway to unforgettable domestic and international adventures'),
    ('hero.button.text', 'Buy Now'),
    ('hero.button.url', 'https://forms.gle/example'),
    ('about.hero.title', 'About TTravel Hospitality'),
    ('about.hero.subtitle', 'Your trusted partner in creating unforgettable travel experiences'),
    ('about.who.title', 'Who We Are'),
    ('about.who.content', 'We are a passionate team of travel enthusiasts dedicated to creating exceptional travel experiences. With years of expertise in the hospitality industry, we specialize in both domestic and international travel packages that cater to every traveler''s needs.'),
    ('about.who.image', 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=800'),
    ('about.mission', 'To provide exceptional, personalized travel experiences that create lasting memories while ensuring the highest standards of service and value for our clients.'),
    ('about.vision', 'To become the leading travel hospitality company, recognized globally for innovative travel solutions and unparalleled customer satisfaction.'),
    ('about.values', 'Excellence in service, integrity in all dealings, innovation in travel solutions, sustainability in tourism practices, and genuine care for our travelers'' experiences.')
ON CONFLICT (key) DO NOTHING;

-- Insert sample destinations
INSERT INTO "destinations" ("name", "description", "image_url", "location", "price", "duration", "category", "features") VALUES 
    ('Goa Beach Paradise', 'Experience the golden beaches and vibrant culture of Goa with our complete beach vacation package.', 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800', 'Goa, India', 15000.00, '4 Days 3 Nights', 'domestic', '{"Beachfront Resort","All Meals","Airport Transfer","Sightseeing"}'),
    ('Kerala Backwaters', 'Cruise through the serene backwaters of Kerala and experience God''s own country.', 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=800', 'Kerala, India', 20000.00, '5 Days 4 Nights', 'domestic', '{"Houseboat Stay","Traditional Cuisine","Ayurvedic Spa","Cultural Shows"}'),
    ('Paris Romance Package', 'Discover the city of love with our romantic Paris getaway package.', 'https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=800', 'Paris, France', 85000.00, '6 Days 5 Nights', 'international', '{"Luxury Hotel","Eiffel Tower Visit","Seine River Cruise","Fine Dining"}'),
    ('Bali Adventure', 'Explore the exotic beauty of Bali with temples, beaches, and cultural experiences.', 'https://images.unsplash.com/photo-1518548419970-58e3b4079ab2?w=800', 'Bali, Indonesia', 45000.00, '7 Days 6 Nights', 'international', '{"Beach Resort","Temple Tours","Adventure Activities","Balinese Cuisine"}'
)
ON CONFLICT DO NOTHING;

-- Insert sample packages
INSERT INTO "packages" ("title", "description", "image_url", "price", "duration", "location", "features", "buy_now_url") VALUES 
    ('Golden Triangle Tour', 'Explore Delhi, Agra, and Jaipur in this comprehensive cultural journey through India''s most iconic destinations.', 'https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800', 35000.00, '6 Days 5 Nights', 'Delhi - Agra - Jaipur', '{"Taj Mahal Visit","Red Fort Tour","Amber Palace","Professional Guide","Luxury Accommodation"}', 'https://forms.gle/golden-triangle'),
    ('Himalayan Adventure', 'Experience the majesty of the Himalayas with trekking, mountain views, and spiritual experiences.', 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800', 25000.00, '8 Days 7 Nights', 'Himachal Pradesh', '{"Mountain Trekking","Scenic Views","Adventure Sports","Local Cuisine","Camping"}', 'https://forms.gle/himalayan-adventure'),
    ('European Explorer', 'Discover multiple European countries in one amazing journey across the continent.', 'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?w=800', 120000.00, '12 Days 11 Nights', 'Europe Multi-City', '{"Multiple Countries","Train Travel","Historic Sites","Cultural Experiences","Guided Tours"}', 'https://forms.gle/european-explorer')
ON CONFLICT DO NOTHING;