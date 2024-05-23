import 'package:dartz/dartz.dart';

import '../../../../core/enums/doctor_category.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/doctor_repository.dart';

class FetchDoctorCategoriesUseCase
    implements UseCase<List<DoctorCategory>, NoParams> {
  final DoctorRepository doctorRepository;

  FetchDoctorCategoriesUseCase({required this.doctorRepository});

  @override
  Future<Either<Failure, List<DoctorCategory>>> call(NoParams params) async {
    return await doctorRepository.fetchDoctorCategories();
  }
}
