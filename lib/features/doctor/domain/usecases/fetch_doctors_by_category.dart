import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../repositories/doctor_repository.dart';

class FetchDoctorsByCategoryUseCase implements UseCase<List<Doctor>, String> {
  final DoctorRepository doctorRepository;

  FetchDoctorsByCategoryUseCase({required this.doctorRepository});

  @override
  Future<Either<Failure, List<Doctor>>> call(String categoryId) async {
    return await doctorRepository.fetchDoctorsByCategory(categoryId);
  }
}
