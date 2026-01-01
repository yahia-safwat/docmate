import 'package:flutter/material.dart';
import '../models/appointment_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<TimeOfDay>> getAvailableSlots({
    required String doctorId,
    required DateTime date,
  });

  Future<AppointmentModel> bookAppointment({
    required AppointmentModel appointment,
  });
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  @override
  Future<List<TimeOfDay>> getAvailableSlots({
    required String doctorId,
    required DateTime date,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Simple mock logic for available slots
    return [
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 16, minute: 0),
    ];
  }

  @override
  Future<AppointmentModel> bookAppointment({
    required AppointmentModel appointment,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // In a real app, this would send to an API
    return appointment;
  }
}
