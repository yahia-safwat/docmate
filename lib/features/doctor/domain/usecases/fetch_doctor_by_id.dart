import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../repositories/doctor_repository.dart';

class FetchDoctorByIdUseCase implements UseCase<Doctor, String> {
  final DoctorRepository doctorRepository;

  FetchDoctorByIdUseCase({required this.doctorRepository});

  @override
  Future<Either<Failure, Doctor>> call(String doctorId) async {
    return await doctorRepository.fetchDoctorById(doctorId);
  }
}
