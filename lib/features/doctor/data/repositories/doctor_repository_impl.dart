import 'package:dartz/dartz.dart';
import '../../../../core/enums/doctor_category.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/repositories/doctor_repository.dart';
import '../data_sources/doctor_remote_data_source.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<DoctorCategory>>> fetchDoctorCategories() async {
    try {
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 1000));
      // Fetch categories from the remote data source
      final categories = await remoteDataSource.getDoctorCategories();
      return Right(categories);
    } catch (e) {
      // Return a failure if there is an error
      return const Left(ServerFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> fetchDoctors() async {
    try {
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 1000));
      // Fetch doctors from the remote data source
      final doctors = await remoteDataSource.getDoctors();
      return Right(doctors.map((doctor) => doctor.toEntity()).toList());
    } catch (e) {
      // Return a failure if there is an error
      return const Left(ServerFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, List<Doctor>>> fetchDoctorsByCategory(
      String categoryId) async {
    try {
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 1000));
      // Fetch doctors by category from the remote data source
      final doctors = await remoteDataSource.getDoctorsByCategory(categoryId);
      return Right(doctors.map((doctor) => doctor.toEntity()).toList());
    } catch (e) {
      // Return a failure if there is an error
      return const Left(ServerFailure(message: 'Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, Doctor>> fetchDoctorById(String doctorId) async {
    try {
      // Simulate a delay
      await Future.delayed(const Duration(milliseconds: 1000));
      // Fetch a doctor by ID from the remote data source
      final doctor = await remoteDataSource.getDoctorById(doctorId);
      return Right(doctor.toEntity());
    } catch (e) {
      // Return a failure if there is an error
      return const Left(ServerFailure(message: 'Something went wrong'));
    }
  }
}
