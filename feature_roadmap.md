# Feature Implementation Roadmap (Clean Architecture)

This roadmap breaks down the missing features into modular components, following the Clean Architecture pattern (Domain, Data, Presentation). We will implement these one by one.

## 1. Feature: Authentication
**Objective:** Enable user access and session management.
- **Domain:** `AuthEntity`, `AuthRepository` interface, `LoginUseCase`, `SignupUseCase`, `LogoutUseCase`.
- **Data:** `AuthModel`, `AuthRemoteDataSource`, `AuthRepositoryImpl`.
- **Presentation:** `LoginBloc`, `SignupBloc`, `LoginPage`, `SignupPage`, `OnboardingScreen`.

---

## 2. Feature: User Profile & Settings
**Objective:** Manage user data and app preferences.
- **Domain:** `UserEntity`, `UpdateProfileUseCase`, `GetAppSettingsUseCase`.
- **Data:** `UserModel`, `UserRepositoryImpl`, `LocalSettingsDataSource`.
- **Presentation:** `ProfileBloc`, `ProfilePage`, `EditProfilePage`, `SettingsPage`.

---

## 3. Feature: Appointment Booking
**Objective:** End-to-end flow for picking slots and confirming appointments.
- **Domain:** `BookingUseCase`, `GetAvailableSlotsUseCase`.
- **Data:** `BookingRepositoryImpl`, `AppointmentDataSource`.
- **Presentation:** `BookingBloc`, `SlotSelectionPage`, `BookingConfirmationPage`, `BookingStatusScreen`.

---

## 4. Feature: Appointments Management
**Objective:** View and manage scheduled consultations.
- **Domain:** `GetAppointmentsUseCase`, `CancelAppointmentUseCase`.
- **Data:** `AppointmentRepositoryImpl` (shared with Booking).
- **Presentation:** `AppointmentsBloc`, `MyAppointmentsPage` (Tabs: Upcoming, History).

---

## 5. Feature: Explore & Search
**Objective:** Advanced doctor discovery.
- **Domain:** `SearchDoctorsUseCase`, `FilterDoctorsUseCase`.
- **Data:** `DoctorRepositoryImpl` (Extend existing).
- **Presentation:** `SearchBloc`, `GlobalSearchPage`, `FilterBottomSheet`.

---

## 6. Feature: Chat / Communication
**Objective:** Real-time messaging with doctors.
- **Domain:** `MessageEntity`, `SendMessageUseCase`, `GetMessagesUseCase`.
- **Data:** `ChatRepositoryImpl`, `ChatRemoteDataSource` (e.g., Firebase).
- **Presentation:** `ChatBloc`, `ChatListPage`, `ChatDetailRoom`.

---

## 7. Feature: Notifications
**Objective:** Push and in-app alerts.
- **Domain:** `NotificationEntity`, `GetNotificationsUseCase`.
- **Data:** `NotificationRepositoryImpl`.
- **Presentation:** `NotificationBloc`, `NotificationListPage`.

---

## Current Focus
> [!IMPORTANT]
> **Priority 1: Authentication**
> Without Authentication, most user-specific features (Booking, Profile, Chat) cannot function correctly.
