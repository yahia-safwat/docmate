# Feature Implementation Roadmap (Clean Architecture)

This roadmap breaks down the missing features into modular components, following the Clean Architecture pattern (Domain, Data, Presentation). We will implement these one by one.

## 1. Feature: Authentication [x]
**Objective:** Enable user access and session management.
- [x] Domain: `AuthEntity`, `AuthRepository` interface, `LoginUseCase`, `SignupUseCase`, `LogoutUseCase`.
- [x] Data: `AuthModel`, `AuthRemoteDataSource`, `AuthRepositoryImpl`.
- [x] Presentation: `LoginBloc`, `SignupBloc`, `LoginPage`, `SignupPage`, `AuthBottomSheet`.

---

## 2. Feature: User Profile & Settings [x]
**Objective:** Manage user data and app preferences.
- [x] Domain: `UserEntity` (via Auth)
- [x] Data: `UserRepositoryImpl` (Integrated with Auth)
- [x] Presentation: `ProfilePage`, `SettingsPage`.

---

## 3. Feature: Appointment Booking [/]
**Objective:** End-to-end flow for picking slots and confirming appointments.
- [ ] Domain: `BookingUseCase`, `GetAvailableSlotsUseCase`.
- [ ] Data: `BookingRepositoryImpl`, `AppointmentDataSource`.
- [ ] Presentation: `BookingBloc`, `SlotSelectionPage`, `BookingConfirmationPage`, `BookingStatusScreen`.

---

## 4. Feature: Appointments Management
**Objective:** View and manage scheduled consultations.
- **Domain:** `GetAppointmentsUseCase`, `CancelAppointmentUseCase`.
- **Data:** `AppointmentRepositoryImpl` (shared with Booking).
- **Presentation:** `AppointmentsBloc`, `MyAppointmentsPage` (Tabs: Upcoming, History).

---

## 5. Feature: Explore & Search [x]
**Objective:** Advanced doctor discovery.
- [x] Domain: `SearchDoctorsUseCase`, `FilterDoctorsUseCase`.
- [x] Data: `DoctorRepositoryImpl` (Extended).
- [x] Presentation: `SearchBloc`, `GlobalSearchPage`, `FilterBottomSheet`.

---

## 6. Feature: Chat / Communication [x]
**Objective:** Real-time messaging with doctors.
- [x] Domain: `MessageEntity`, `SendMessageUseCase`, `GetMessagesUseCase`.
- [x] Data: `ChatRepositoryImpl`, `ChatRemoteDataSource` (Mock).
- [x] Presentation: `ChatBloc`, `ChatListPage`, `ChatDetailRoom`.

---

## 7. Feature: Notifications [/]
**Objective:** Push and in-app alerts.
- [ ] Domain: `NotificationEntity`, `GetNotificationsUseCase`.
- [ ] Data: `NotificationRepositoryImpl`.
- [ ] Presentation: `NotificationBloc`, `NotificationListPage`.

---

## Current Focus
> [!IMPORTANT]
> **Priority 7: Notifications**
> We are now implementing the notification system to alert users of appointments and messages.
