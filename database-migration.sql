-- Hostel Management System - Database Migration Script
-- Run this in your Supabase SQL Editor

-- =====================================================
-- 1. USERS TABLE (for authentication)
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  username VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('Admin', 'Staff')),
  staff_id UUID REFERENCES staff(id) ON DELETE SET NULL,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster username lookups
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- =====================================================
-- 2. STAFF TABLE (updated with new fields)
-- =====================================================
-- First, check if staff table exists and add new columns
ALTER TABLE staff ADD COLUMN IF NOT EXISTS phone VARCHAR(50);
ALTER TABLE staff ADD COLUMN IF NOT EXISTS thai_id VARCHAR(50);
ALTER TABLE staff ADD COLUMN IF NOT EXISTS address TEXT;
ALTER TABLE staff ADD COLUMN IF NOT EXISTS emergency_contact VARCHAR(255);
ALTER TABLE staff ADD COLUMN IF NOT EXISTS birthday DATE;
ALTER TABLE staff ADD COLUMN IF NOT EXISTS id_photo_url TEXT;

-- If staff table doesn't exist, create it with all fields
CREATE TABLE IF NOT EXISTS staff (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  role VARCHAR(50) NOT NULL CHECK (role IN ('Admin', 'Staff')),
  salary DECIMAL(10, 2) NOT NULL,
  contact VARCHAR(255) NOT NULL,
  employee_id VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(50),
  thai_id VARCHAR(50),
  address TEXT,
  emergency_contact VARCHAR(255),
  birthday DATE,
  id_photo_url TEXT
);

-- =====================================================
-- 3. OTHER CORE TABLES
-- =====================================================

-- Rooms Table
CREATE TABLE IF NOT EXISTS rooms (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  condition VARCHAR(50) NOT NULL,
  maintenance_notes TEXT,
  beds JSONB DEFAULT '[]'::JSONB
);

-- Tasks Table
CREATE TABLE IF NOT EXISTS tasks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  description TEXT NOT NULL,
  assigned_to UUID REFERENCES staff(id) ON DELETE CASCADE,
  due_date DATE NOT NULL,
  status VARCHAR(50) NOT NULL CHECK (status IN ('Pending', 'In Progress', 'Completed'))
);

-- Shifts Table  
CREATE TABLE IF NOT EXISTS shifts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  date DATE NOT NULL,
  staff_name VARCHAR(255) NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL
);

-- Absences Table
CREATE TABLE IF NOT EXISTS absences (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  staff_id UUID REFERENCES staff(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  reason TEXT
);

-- Salary Advances Table
CREATE TABLE IF NOT EXISTS salary_advances (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  staff_id UUID REFERENCES staff(id) ON DELETE CASCADE,
  date DATE NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  reason TEXT
);

-- Utility Records Table
CREATE TABLE IF NOT EXISTS utility_records (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  utility_type VARCHAR(255) NOT NULL,
  date DATE NOT NULL,
  cost DECIMAL(10, 2) NOT NULL,
  bill_image TEXT
);

-- Utility Categories Table
CREATE TABLE IF NOT EXISTS utility_categories (
  name VARCHAR(255) PRIMARY KEY
);

-- Activities Table
CREATE TABLE IF NOT EXISTS activities (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  image_url TEXT,
  commission DECIMAL(10, 2),
  type VARCHAR(50) NOT NULL CHECK (type IN ('Internal', 'External')),
  company_cost DECIMAL(10, 2)
);

-- Speed Boat Trips Table
CREATE TABLE IF NOT EXISTS speed_boat_trips (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  route VARCHAR(255) NOT NULL,
  company VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  cost DECIMAL(10, 2) NOT NULL,
  commission DECIMAL(10, 2)
);

-- Taxi Boat Options Table
CREATE TABLE IF NOT EXISTS taxi_boat_options (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(50) NOT NULL CHECK (name IN ('One Way', 'Round Trip')),
  price DECIMAL(10, 2) NOT NULL,
  commission DECIMAL(10, 2)
);

-- Extras Table
CREATE TABLE IF NOT EXISTS extras (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  commission DECIMAL(10, 2)
);

-- Bookings Table
CREATE TABLE IF NOT EXISTS bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  item_id UUID NOT NULL,
  item_type VARCHAR(50) NOT NULL,
  item_name VARCHAR(255) NOT NULL,
  staff_id UUID REFERENCES staff(id) ON DELETE SET NULL,
  booking_date DATE NOT NULL,
  customer_price DECIMAL(10, 2) NOT NULL,
  number_of_people INTEGER NOT NULL,
  discount DECIMAL(10, 2),
  extras JSONB,
  extras_total DECIMAL(10, 2),
  payment_method VARCHAR(100) NOT NULL,
  receipt_image TEXT,
  fuel_cost DECIMAL(10, 2),
  captain_cost DECIMAL(10, 2),
  item_cost DECIMAL(10, 2),
  employee_commission DECIMAL(10, 2),
  hostel_commission DECIMAL(10, 2)
);

-- External Sales Table
CREATE TABLE IF NOT EXISTS external_sales (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  date DATE NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  description TEXT
);

-- Platform Payments Table
CREATE TABLE IF NOT EXISTS platform_payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  date DATE NOT NULL,
  platform VARCHAR(255) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  booking_reference VARCHAR(255)
);

-- Walk-In Guests Table
CREATE TABLE IF NOT EXISTS walk_in_guests (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  guest_name VARCHAR(255) NOT NULL,
  room_id UUID REFERENCES rooms(id) ON DELETE SET NULL,
  bed_number INTEGER,
  check_in_date DATE NOT NULL,
  number_of_nights INTEGER NOT NULL,
  price_per_night DECIMAL(10, 2) NOT NULL,
  amount_paid DECIMAL(10, 2) NOT NULL,
  payment_method VARCHAR(100) NOT NULL,
  nationality VARCHAR(100),
  id_number VARCHAR(100),
  notes TEXT,
  status VARCHAR(50) NOT NULL CHECK (status IN ('Paid', 'Deposit Paid', 'Unpaid'))
);

-- Accommodation Bookings Table
CREATE TABLE IF NOT EXISTS accommodation_bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  guest_name VARCHAR(255) NOT NULL,
  platform VARCHAR(255) NOT NULL,
  room_id UUID REFERENCES rooms(id) ON DELETE SET NULL,
  bed_number INTEGER,
  check_in_date DATE NOT NULL,
  number_of_nights INTEGER NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  amount_paid DECIMAL(10, 2) NOT NULL,
  status VARCHAR(50) NOT NULL CHECK (status IN ('Paid', 'Deposit Paid', 'Unpaid'))
);

-- Payment Types Table
CREATE TABLE IF NOT EXISTS payment_types (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) UNIQUE NOT NULL
);

-- =====================================================
-- 4. INSERT DEFAULT DATA
-- =====================================================

-- Insert default payment types if they don't exist
INSERT INTO payment_types (name) VALUES 
  ('Cash'),
  ('Credit Card'),
  ('Bank Transfer'),
  ('PayPal'),
  ('Promptpay')
ON CONFLICT (name) DO NOTHING;

-- Insert default utility categories if they don't exist
INSERT INTO utility_categories (name) VALUES 
  ('Electricity'),
  ('Water'),
  ('Internet'),
  ('Gas')
ON CONFLICT (name) DO NOTHING;

-- Insert default admin user if no users exist
INSERT INTO users (username, password, role, is_active)
SELECT 'admin', 'admin123', 'Admin', true
WHERE NOT EXISTS (SELECT 1 FROM users LIMIT 1);

-- =====================================================
-- 5. CREATE INDEXES FOR PERFORMANCE
-- =====================================================

CREATE INDEX IF NOT EXISTS idx_staff_employee_id ON staff(employee_id);
CREATE INDEX IF NOT EXISTS idx_tasks_assigned_to ON tasks(assigned_to);
CREATE INDEX IF NOT EXISTS idx_tasks_due_date ON tasks(due_date);
CREATE INDEX IF NOT EXISTS idx_absences_staff_id ON absences(staff_id);
CREATE INDEX IF NOT EXISTS idx_absences_date ON absences(date);
CREATE INDEX IF NOT EXISTS idx_salary_advances_staff_id ON salary_advances(staff_id);
CREATE INDEX IF NOT EXISTS idx_bookings_staff_id ON bookings(staff_id);
CREATE INDEX IF NOT EXISTS idx_bookings_booking_date ON bookings(booking_date);
CREATE INDEX IF NOT EXISTS idx_walk_in_guests_check_in_date ON walk_in_guests(check_in_date);
CREATE INDEX IF NOT EXISTS idx_accommodation_bookings_check_in_date ON accommodation_bookings(check_in_date);

-- =====================================================
-- 6. ROW LEVEL SECURITY (Optional - Recommended)
-- =====================================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE staff ENABLE ROW LEVEL SECURITY;
ALTER TABLE rooms ENABLE ROW LEVEL SECURITY;
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE shifts ENABLE ROW LEVEL SECURITY;
ALTER TABLE absences ENABLE ROW LEVEL SECURITY;
ALTER TABLE salary_advances ENABLE ROW LEVEL SECURITY;
ALTER TABLE utility_records ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE speed_boat_trips ENABLE ROW LEVEL SECURITY;
ALTER TABLE taxi_boat_options ENABLE ROW LEVEL SECURITY;
ALTER TABLE extras ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE external_sales ENABLE ROW LEVEL SECURITY;
ALTER TABLE platform_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE walk_in_guests ENABLE ROW LEVEL SECURITY;
ALTER TABLE accommodation_bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE utility_categories ENABLE ROW LEVEL SECURITY;

-- Create policies for authenticated users (modify based on your auth setup)
-- For now, allow all operations for authenticated users
-- You can customize these policies based on roles later

CREATE POLICY "Allow all operations for authenticated users" ON users
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON staff
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON rooms
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON tasks
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON shifts
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON absences
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON salary_advances
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON utility_records
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON activities
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON speed_boat_trips
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON taxi_boat_options
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON extras
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON bookings
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON external_sales
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON platform_payments
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON walk_in_guests
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON accommodation_bookings
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON payment_types
  FOR ALL USING (true) WITH CHECK (true);

CREATE POLICY "Allow all operations for authenticated users" ON utility_categories
  FOR ALL USING (true) WITH CHECK (true);

-- =====================================================
-- MIGRATION COMPLETE!
-- =====================================================
