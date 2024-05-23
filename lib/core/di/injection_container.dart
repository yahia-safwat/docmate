import 'package:get_it/get_it.dart';

import '../../features/doctor/data/data_sources/doctor_remote_data_source.dart';
import '../../features/doctor/data/repositories/doctor_repository_impl.dart';
import '../../features/doctor/domain/repositories/doctor_repository.dart';
import '../../features/doctor/domain/usecases/fetch_doctor_by_id.dart';
import '../../features/doctor/domain/usecases/fetch_doctor_categories.dart';
import '../../features/doctor/domain/usecases/fetch_doctors.dart';
import '../../features/doctor/domain/usecases/fetch_doctors_by_category.dart';
import '../../features/home/presentation/blocs/home/home_bloc.dart';

//! Service Locator Setup
final sl = GetIt.instance;

Future<void> init() async {
//! Common: [App] :-----------------------------------

//! Core: :-----------------------------------
  // sl.registerLazySingleton<SharedPrefsService>(() => SharedPrefsService());

//! Features: [Restaurant] :-----------------------------------
  // Blocs
  sl.registerFactory(() => HomeBloc(
        fetchDoctorCategoriesUseCase: sl(),
        fetchDoctorsUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(
      () => FetchDoctorCategoriesUseCase(doctorRepository: sl()));
  sl.registerLazySingleton(() => FetchDoctorsUseCase(doctorRepository: sl()));
  sl.registerLazySingleton(
      () => FetchDoctorByIdUseCase(doctorRepository: sl()));
  sl.registerLazySingleton(
      () => FetchDoctorsByCategoryUseCase(doctorRepository: sl()));

  // Repository
  sl.registerLazySingleton<DoctorRepository>(
      () => DoctorRepositoryImpl(remoteDataSource: sl()));

  // Remote Data sources
  sl.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSourceImpl(),
  );

  // Firebase Services
  //! External: :-----------------------------------
}

//! Helper Functions

