import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/doctor/data/data_sources/doctor_remote_data_source.dart';
import '../../features/doctor/data/repositories/doctor_repository_impl.dart';
import '../../features/doctor/domain/repositories/doctor_repository.dart';
import '../../features/doctor/domain/usecases/fetch_doctor_by_id.dart';
import '../../features/doctor/domain/usecases/fetch_doctor_categories.dart';
import '../../features/doctor/domain/usecases/fetch_doctors.dart';
import '../../features/doctor/domain/usecases/fetch_doctors_by_category.dart';
import '../../features/doctor/presentation/blocs/doctor_details/doctor_details_bloc.dart';
import '../../features/home/presentation/blocs/home/home_bloc.dart';
import '../../features/auth/data/data_sources/auth_local_data_source.dart';
import '../../features/auth/data/data_sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/get_authenticated_user_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/doctor/domain/usecases/search_doctors_usecase.dart';
import '../../features/doctor/domain/usecases/filter_doctors_usecase.dart';
import '../../features/doctor/presentation/blocs/search/search_bloc.dart';
import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../../features/chat/data/data_sources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/get_chats_usecase.dart';
import '../../features/chat/domain/usecases/get_messages_usecase.dart';
import '../../features/chat/domain/usecases/send_message_usecase.dart';
import '../../features/chat/presentation/blocs/chat/chat_bloc.dart';
import '../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../features/appointment/data/data_sources/booking_local_data_source.dart';
import '../../features/appointment/data/data_sources/booking_remote_data_source.dart';
import '../../features/appointment/data/repositories/booking_repository_impl.dart';
import '../../features/appointment/domain/repositories/booking_repository.dart';
import '../../features/appointment/domain/usecases/book_appointment_usecase.dart';
import '../../features/appointment/domain/usecases/cancel_appointment_usecase.dart';
import '../../features/appointment/domain/usecases/get_appointments_usecase.dart';
import '../../features/appointment/domain/usecases/get_available_slots_usecase.dart';
import '../../features/appointment/presentation/blocs/booking/booking_bloc.dart';
import '../../features/appointment/presentation/blocs/my_appointments/my_appointments_bloc.dart';

//! Service Locator Setup
final sl = GetIt.instance;

Future<void> init() async {
  //! Common: [App] :-----------------------------------

  //! Core: :-----------------------------------
  // sl.registerLazySingleton<SharedPrefsService>(() => SharedPrefsService());

  //! Features: [Restaurant] :-----------------------------------
  // Blocs
  sl.registerFactory(
    () =>
        HomeBloc(fetchDoctorCategoriesUseCase: sl(), fetchDoctorsUseCase: sl()),
  );
  sl.registerFactory(() => DoctorDetailsBloc(fetchDoctorByIdUseCase: sl()));

  // Auth BLoCs
  sl.registerFactory(() => AuthBloc(getAuthenticatedUser: sl(), logout: sl()));
  sl.registerFactory(() => LoginBloc(login: sl()));

  // Booking BLoC
  sl.registerFactory(
    () => BookingBloc(getAvailableSlots: sl(), bookAppointment: sl()),
  );
  sl.registerFactory(
    () => MyAppointmentsBloc(getAppointments: sl(), cancelAppointment: sl()),
  );
  sl.registerFactory(
    () => SearchBloc(searchDoctors: sl(), filterDoctors: sl()),
  );
  sl.registerFactory(
    () => ChatBloc(
      getChatsUseCase: sl(),
      getMessagesUseCase: sl(),
      sendMessageUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
    () => FetchDoctorCategoriesUseCase(doctorRepository: sl()),
  );
  sl.registerLazySingleton(() => FetchDoctorsUseCase(doctorRepository: sl()));
  sl.registerLazySingleton(
    () => FetchDoctorByIdUseCase(doctorRepository: sl()),
  );
  sl.registerLazySingleton(
    () => FetchDoctorsByCategoryUseCase(doctorRepository: sl()),
  );
  sl.registerLazySingleton(() => SearchDoctorsUseCase(sl()));
  sl.registerLazySingleton(() => FilterDoctorsUseCase(sl()));
  sl.registerLazySingleton(() => GetChatsUseCase(sl()));
  sl.registerLazySingleton(() => GetMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));

  // Booking Use cases
  sl.registerLazySingleton(() => GetAvailableSlotsUseCase(repository: sl()));
  sl.registerLazySingleton(() => BookAppointmentUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetAppointmentsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CancelAppointmentUseCase(repository: sl()));

  // Auth Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthenticatedUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

  // Booking Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Remote Data sources
  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );

  // Booking Data sources
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<BookingLocalDataSource>(
    () => BookingLocalDataSourceImpl(),
  );

  // Auth Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External Dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Firebase Services
  //! External: :-----------------------------------
}

//! Helper Functions
