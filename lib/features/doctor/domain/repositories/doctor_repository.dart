import 'package:dartz/dartz.dart';

import '../../../../core/enums/doctor_category.dart';
import '../../../../core/errors/failures.dart';
import '../entities/doctor.dart';

abstract class DoctorRepository {
  Future<Either<Failure, List<DoctorCategory>>> fetchDoctorCategories();
  Future<Either<Failure, List<Doctor>>> fetchDoctors();
  Future<Either<Failure, List<Doctor>>> fetchDoctorsByCategory(
      String categoryId);
  Future<Either<Failure, Doctor>> fetchDoctorById(String doctorId);
}
