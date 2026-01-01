# DocMate - Analysis of Features and Pages

This document outlines the current state of the DocMate application and identifies the features and pages required to make it a fully functional healthcare platform.

## Currently Implemented

### Features
- **Home/Discover**: Basic structure for the home page with a welcome message and location display.
- **Doctor Management**: 
  - Entities and Models defined for Doctors, Reviews, and Working Hours.
  - Doctor Details page displaying info, reviews, and working hours.
  - Basic Doctor Card UI.
- **Clinic/Appointment Entities**: Basic domain models for clinics and appointments.
- **Theme & Navigation**: 
  - Centralized theme and color scheme.
  - Bottom Navigation Bar (Skeleton).
  - Basic GoRouter implementation for Home and Doctor Details.

### Pages
- **Home Page**: `lib/features/home/presentation/pages/home_page.dart`
- **Doctor Details Page**: `lib/features/doctor/presentation/pages/doctor_details/doctor_details_page.dart`

---

## Missing Features (To be Implemented)

### 1. Authentication & User Management
- **User Authentication**: Login, Signup, Social Login (Google/Apple), and Forgot Password.
- **Onboarding**: Welcome screens and initial profile setup for users.
- **User Session**: Persistent login and logout functionality.

### 2. Appointment Booking Flow
- **Booking UI**: Missing the actual presentation layer to select a doctor, pick a date/time slot, and confirm.
- **Payment Integration**: (Optional but common) Integrating a payment gateway for consultation fees.
- **Booking Success/Failure**: Feedback screens after attempting to book.

### 3. Search & Exploration
- **Explore Feed**: Advanced filtering of doctors by specialty, rating, or proximity.
- **Search Functionality**: A dedicated search page or global search bar to find specific doctors or clinics.

### 4. Communication (Chat)
- **Chat System**: Messaging between patients and doctors/clinics.
- **Chat List**: Overview of all active conversations.
- **Chat Screen**: Real-time message exchange UI.

### 5. User Profile & Settings
- **Profile Page**: View and edit personal information, medical history (optional), and saved doctors.
- **Settings**: App preferences (dark/light mode), notification toggles, and account management.
- **Appointments Management**: "My Appointments" page to view upcoming, past, and canceled bookings.

### 6. Notifications
- **In-app/Push Notifications**: Reminders for upcoming appointments, chat messages, and system alerts.

### 7. Reviews & Feedback
- **Review Submission**: UI for patients to leave ratings and reviews for doctors after appointments.

---

## Missing Pages (Required for Functional App)

| Feature Area | Required Pages |
| :--- | :--- |
| **Authentication** | Login, Signup, Forgot Password, Verification, Onboarding |
| **Booking** | Appointment Selection, Confirmation, Booking Status (Success/Fail) |
| **Appointments** | My Appointments (Tabs: Upcoming, History, Canceled) |
| **Community/Communication** | Chat List, Chat Interaction Screen |
| **Profile** | View Profile, Edit Profile, Favorites, Settings, About |
| **Search** | Global Search Results, Category Filter Results |
| **Clinic** | Clinic Details Page (Currently only Doctor Details exists) |

## Technical Implementation Needs
- **Data Persistence**: Integration with a real database (Firebase, Supabase, or REST API). Currently using mostly mock or skeleton logic.
- **State Management**: Fully implementing BLoC across all features (already partially started in Home/Doctor).
- **Navigation**: Expanding `AppRouter` to include all the missing routes mentioned above.
