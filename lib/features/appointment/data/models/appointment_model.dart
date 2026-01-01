// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/appointment.dart';
import '../../../../core/enums/appointment_status.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 0)
class AppointmentModel extends Appointment {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String doctorId;
  @override
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final int hour;
  @HiveField(4)
  final int minute;
  @override
  @HiveField(5)
  final String? reason;
  @override
  @HiveField(6)
  final AppointmentStatus? status;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.hour,
    required this.minute,
    this.reason,
    this.status,
  }) : super(
         id: id,
         doctorId: doctorId,
         date: date,
         time: TimeOfDay(hour: hour, minute: minute),
         reason: reason,
         status: status,
       );

  factory AppointmentModel.fromEntity(Appointment entity) {
    return AppointmentModel(
      id: entity.id,
      doctorId: entity.doctorId,
      date: entity.date,
      hour: entity.time.hour,
      minute: entity.time.minute,
      reason: entity.reason,
      status: entity.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'hour': hour,
      'minute': minute,
      'reason': reason,
      'status': status?.name,
    };
  }
}
