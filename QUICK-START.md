# 🚀 Quick Start Deployment Guide

## Step-by-Step Setup (5 minutes)

### 1. Setup Supabase (2 minutes)
1. Go to https://supabase.com and sign up (it's free!)
2. Click "New Project"
3. Fill in:
   - Project name: "hostel-management" (or any name you like)
   - Database password: (create a strong password)
   - Region: Choose closest to you
4. Wait for the project to be ready (about 1-2 minutes)

### 2. Create Database Tables (1 minute)
1. In your Supabase dashboard, click on "SQL Editor" in the left sidebar
2. Click "New Query"
3. Open the file `database-migration.sql` from this project folder
4. Copy ALL the contents (Ctrl+A, then Ctrl+C)
5. Paste into the Supabase SQL Editor (Ctrl+V)
6. Click "Run" at the bottom right
7. Wait until you see "Success. No rows returned"

### 3. Get Your API Keys (30 seconds)
1. In Supabase, click on the "Settings" icon (gear icon) at the bottom left
2. Click on "API" in the settings menu
3. You'll see two important things:
   - **Project URL** - looks like: `https://xxxxxxxxxxxxx.supabase.co`
   - **Anon Public Key** - a long string of characters

   Keep this page open, you'll need these in the next step!

### 4. Configure the App (1 minute)
1. Open the file `lib/supabaseClient.ts` in this project
2. Replace the placeholder values:

```typescript
const supabaseUrl = 'YOUR_SUPABASE_URL'; // Paste your Project URL here
const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY'; // Paste your Anon Key here
```

Example (DO NOT USE THESE - they're just examples):
```typescript
const supabaseUrl = 'https://abcdefghijk.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

3. Save the file (Ctrl+S)

### 5. Install and Run (1 minute)
Open your terminal/command prompt in the project folder and run:

```bash
npm install
```

Wait for it to finish, then run:

```bash
npm run dev
```

You should see:
```
➜  Local:   http://localhost:5173/
```

Open your browser and go to http://localhost:5173/

### 6. First Login
- Username: `admin`
- Password: `admin123`

**IMPORTANT:** After logging in:
1. Click on "User Management" tab
2. Click the edit button on the admin user
3. Change the password to something secure
4. Click "Update User"

## 🎉 You're Done!

Your hostel management system is now running locally!

## What's Next?

### To Use It Daily:
Just run `npm run dev` in the project folder whenever you want to use the app.

### To Deploy Online (Make it accessible from anywhere):

#### Option A: Vercel (Recommended - Easiest)
1. Create account at https://vercel.com (free)
2. Click "Add New Project"
3. Import your project from GitHub or upload the folder
4. Click "Deploy"
5. Done! You'll get a URL like `https://your-hostel-management.vercel.app`

#### Option B: Netlify
1. Create account at https://netlify.com (free)
2. Drag and drop your project folder (after running `npm run build`)
3. Done! You'll get a URL

## 📱 Using the System

### For Admins:
- Manage users (User Management tab)
- Add/edit employees (Staff & HR tab)
- View financial reports (Activities tab → Reports)
- Manage rooms and bookings

### For Staff:
- Manage rooms and beds
- Create bookings
- Track utilities

## ⚠️ Important Notes

1. **Backup Your Database**: Supabase has automatic backups on paid plans, but you can also manually export your data
2. **Change Default Password**: Never use the default password in production
3. **Secure Your Keys**: Don't share your Supabase URL and keys publicly
4. **Update Regularly**: Keep your dependencies updated with `npm update`

## 🆘 Need Help?

### Common Issues:

**"Cannot connect to database"**
- Check if you updated `lib/supabaseClient.ts` with your actual keys
- Verify your internet connection
- Make sure your Supabase project is active

**"Login not working"**
- Make sure you ran the database migration SQL
- Check if the users table exists in Supabase (Database → Tables)
- Try the default credentials: admin / admin123

**"Page is blank"**
- Check the browser console (F12) for errors
- Make sure all dependencies are installed (`npm install`)
- Try clearing browser cache and reloading

**"Build failed"**
- Delete node_modules folder and package-lock.json
- Run `npm install` again
- Make sure you have Node.js 16+ installed

## 💡 Tips

- Use Chrome or Firefox for the best experience
- The system works great on tablets and mobile devices too
- Take regular backups of your Supabase database
- Create different user accounts for different staff members

---

**Enjoy your new hostel management system!** 🏨✨
