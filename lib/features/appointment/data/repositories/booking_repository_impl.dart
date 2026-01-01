import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/booking_repository.dart';
import '../data_sources/booking_remote_data_source.dart';
import '../models/appointment_model.dart';

import '../data_sources/booking_local_data_source.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Appointment>> bookAppointment({
    required Appointment appointment,
  }) async {
    try {
      final model = AppointmentModel.fromEntity(appointment);
      final result = await remoteDataSource.bookAppointment(appointment: model);

      // Cache locally
      await localDataSource.cacheAppointment(result);

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

  @override
  Future<Either<Failure, List<Appointment>>> getAppointments() async {
    try {
      final result = await localDataSource.getAppointments();
      return Right(result);
    } catch (e) {
      return const Left(
        CacheFailure(message: 'Failed to load local appointments'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> cancelAppointment(String id) async {
    try {
      await localDataSource.deleteAppointment(id);
      return const Right(null);
    } catch (e) {
      return const Left(
        CacheFailure(message: 'Failed to cancel local appointment'),
      );
    }
  }
}
