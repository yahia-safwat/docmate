import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/booking_repository.dart';

class GetAppointmentsUseCase implements UseCase<List<Appointment>, NoParams> {
  final BookingRepository repository;

  GetAppointmentsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Appointment>>> call(NoParams params) async {
    return await repository.getAppointments();
  }
}
