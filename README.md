# Hostel Management System - Complete Edition

A comprehensive hostel management application built with React, TypeScript, and Supabase, featuring complete user authentication, enhanced employee management, and automated financial reporting.

## 🎯 New Features Added

### 1. **User Management System**
- Add/Edit/Delete admin and staff users directly from the UI
- Each user gets their own login credentials (username + password)
- Role-based access control (Admin/Staff)
- Active/Inactive user status management
- Secure password storage
- User activity tracking

### 2. **Enhanced Employee Management**
The employee form now includes:
- ✅ Phone Number field
- ✅ Thai ID Number field
- ✅ Full Address field
- ✅ Emergency Contact information
- ✅ Birthday field
- ✅ ID Photo Upload with preview

### 3. **Improved Financial Reporting**
- Platform Payments are now **automatically included** in the total Accommodation Revenue
- More accurate financial reporting in the Booking Reports section
- Better tracking of all revenue streams

## 🚀 Getting Started

### Prerequisites
- Node.js 16+ installed
- A Supabase account (free tier works fine)
- Git (optional, for version control)

### Installation Steps

#### 1. Set Up Supabase Database

1. Go to [Supabase](https://supabase.com) and create a new project
2. Once your project is ready, go to the **SQL Editor**
3. Open the file `database-migration.sql` from this project
4. Copy the entire contents and paste it into the Supabase SQL Editor
5. Click **Run** to execute the migration script
6. This will create all necessary tables, indexes, and default data

#### 2. Configure Your App

1. Go to your Supabase project settings
2. Navigate to **API** section
3. Copy your **Project URL** and **Anon Public Key**
4. Update the `lib/supabaseClient.ts` file with your credentials:

```typescript
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'YOUR_SUPABASE_URL';
const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
```

#### 3. Install Dependencies

```bash
npm install
```

#### 4. Run the Development Server

```bash
npm run dev
```

The application will open at `http://localhost:5173`

## 🔐 Default Login Credentials

After running the database migration, you'll have a default admin account:

- **Username:** `admin`
- **Password:** `admin123`

⚠️ **IMPORTANT:** Change this password immediately after first login by:
1. Going to the "User Management" tab
2. Editing the admin user
3. Setting a strong password

## 📦 Building for Production

### Build the Application

```bash
npm run build
```

This creates a `dist` folder with optimized production files.

### Deploy to Vercel

1. Push your code to GitHub
2. Go to [Vercel](https://vercel.com) and import your repository
3. Vercel will automatically detect the Vite configuration
4. Deploy!

### Deploy to Netlify

1. Push your code to GitHub
2. Go to [Netlify](https://netlify.com) and connect your repository
3. Build command: `npm run build`
4. Publish directory: `dist`
5. Deploy!

## 🔧 Configuration

### Enabling Row Level Security (RLS)

The migration script automatically enables RLS. For production, consider implementing stricter policies based on your authentication system.

## 📱 Features Overview

### For Admins
- ✅ Full access to all modules
- ✅ User Management (create/edit/delete users)
- ✅ Staff & HR Management
- ✅ Room & Bed Management
- ✅ Activities & Tours Management
- ✅ Financial Reports
- ✅ Booking Management
- ✅ Utilities Tracking

### For Staff
- ✅ Room & Bed Management
- ✅ Activities & Tours Management
- ✅ Booking Management
- ✅ Utilities Tracking
- ❌ No access to User Management
- ❌ No access to Staff & HR

## 🛠️ Troubleshooting

### "Cannot read property of undefined" errors
- Ensure all database tables are created correctly
- Check your Supabase credentials in `lib/supabaseClient.ts`
- Verify RLS policies allow data access

### Login issues
- Confirm the users table has at least one active admin user
- Check the browser console for error messages
- Verify your database connection

### Build errors
- Run `npm install` to ensure all dependencies are installed
- Check for TypeScript errors: `npm run type-check` (if available)

## 🔒 Security Best Practices

1. **Change default passwords** immediately
2. **Never commit** Supabase credentials to version control
3. **Enable HTTPS** in production
4. **Regularly backup** your database
5. **Use strong passwords** for all user accounts
6. **Audit user access** regularly through the User Management tab

## 📊 Database Structure

### Key Tables
- `users` - Login credentials and user management
- `staff` - Employee information with enhanced fields
- `rooms` - Room and bed management
- `bookings` - Activity and tour bookings
- `walk_in_guests` - Walk-in accommodation guests
- `accommodation_bookings` - Platform bookings
- `platform_payments` - Payments from booking platforms (now included in accommodation revenue)
- `external_sales` - Other sales revenue
- `utility_records` - Utility expenses tracking
- `absences` - Employee absence tracking
- `salary_advances` - Salary advance tracking

## 🎉 Deployment Checklist

Before deploying to production:

- [ ] Run database migration successfully
- [ ] Update `lib/supabaseClient.ts` with your Supabase credentials
- [ ] Change default admin password
- [ ] Test all CRUD operations
- [ ] Test user login/logout
- [ ] Verify role-based access control
- [ ] Test on mobile devices
- [ ] Enable HTTPS
- [ ] Set up regular database backups
- [ ] Test the build locally: `npm run build && npm run preview`

---

**Version:** 2.0.0  
**Last Updated:** November 2024  
**Built with:** React + TypeScript + Vite + Supabase
