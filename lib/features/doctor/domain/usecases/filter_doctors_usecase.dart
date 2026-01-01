import 'package:dartz/dartz.dart';
import '../../../../core/enums/doctor_category.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/doctor.dart';
import '../repositories/doctor_repository.dart';

class FilterDoctorsUseCase implements UseCase<List<Doctor>, FilterParams> {
  final DoctorRepository repository;

  FilterDoctorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Doctor>>> call(FilterParams params) async {
    return await repository.filterDoctors(params);
  }
}

class FilterParams {
  final List<DoctorCategory>? categories;
  final double? minRating;
  final double? maxPrice;

  FilterParams({this.categories, this.minRating, this.maxPrice});
}
