import 'package:get_it/get_it.dart';

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
import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../../features/auth/presentation/blocs/login/login_bloc.dart';
import '../../features/appointment/data/data_sources/booking_remote_data_source.dart';
import '../../features/appointment/data/repositories/booking_repository_impl.dart';
import '../../features/appointment/domain/repositories/booking_repository.dart';
import '../../features/appointment/domain/usecases/book_appointment_usecase.dart';
import '../../features/appointment/domain/usecases/get_available_slots_usecase.dart';
import '../../features/appointment/presentation/blocs/booking/booking_bloc.dart';

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

  // Booking Use cases
  sl.registerLazySingleton(() => GetAvailableSlotsUseCase(repository: sl()));
  sl.registerLazySingleton(() => BookAppointmentUseCase(repository: sl()));

  // Auth Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthenticatedUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<DoctorRepository>(
    () => DoctorRepositoryImpl(remoteDataSource: sl()),
  );

  // Booking Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: sl()),
  );

  // Auth Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // Remote Data sources
  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(),
  );

  // Booking Data source
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(),
  );

  // Auth Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  // Firebase Services
  //! External: :-----------------------------------
}

//! Helper Functions
