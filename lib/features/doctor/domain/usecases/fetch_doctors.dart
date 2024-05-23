import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../repositories/doctor_repository.dart';

class FetchDoctorsUseCase extends UseCase<List<Doctor>, NoParams> {
  final DoctorRepository doctorRepository;

  FetchDoctorsUseCase({required this.doctorRepository});

  @override
  Future<Either<Failure, List<Doctor>>> call(NoParams params) async {
    return await doctorRepository.fetchDoctors();
  }
}
