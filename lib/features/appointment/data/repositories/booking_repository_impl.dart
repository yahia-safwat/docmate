import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/booking_repository.dart';
import '../data_sources/booking_remote_data_source.dart';
import '../models/appointment_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Appointment>> bookAppointment({
    required Appointment appointment,
  }) async {
    try {
      final model = AppointmentModel.fromEntity(appointment);
      final result = await remoteDataSource.bookAppointment(appointment: model);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure(message: 'Server Error'));
    }
  }

  @override
  Future<Either<Failure, List<TimeOfDay>>> getAvailableSlots({
    required String doctorId,
    required DateTime date,
  }) async {
    try {
      final result = await remoteDataSource.getAvailableSlots(
        doctorId: doctorId,
        date: date,
      );
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure(message: 'Server Error'));
    }
  }
}
