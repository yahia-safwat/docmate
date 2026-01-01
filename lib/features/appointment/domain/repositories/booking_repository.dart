import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/appointment.dart';
import 'package:flutter/material.dart';

abstract class BookingRepository {
  Future<Either<Failure, List<TimeOfDay>>> getAvailableSlots({
    required String doctorId,
    required DateTime date,
  });

  Future<Either<Failure, Appointment>> bookAppointment({
    required Appointment appointment,
  });

  Future<Either<Failure, List<Appointment>>> getAppointments();

  Future<Either<Failure, void>> cancelAppointment(String id);
}
