import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/booking_repository.dart';

class CancelAppointmentUseCase implements UseCase<void, String> {
  final BookingRepository repository;

  CancelAppointmentUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.cancelAppointment(id);
  }
}
