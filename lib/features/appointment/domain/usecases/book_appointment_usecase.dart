import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/appointment.dart';
import '../repositories/booking_repository.dart';

class BookAppointmentUseCase implements UseCase<Appointment, Appointment> {
  final BookingRepository repository;

  BookAppointmentUseCase({required this.repository});

  @override
  Future<Either<Failure, Appointment>> call(Appointment appointment) async {
    return await repository.bookAppointment(appointment: appointment);
  }
}
