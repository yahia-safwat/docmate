import 'package:flutter/material.dart';
import '../../../../core/enums/appointment_status.dart';
import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.doctorId,
    // required String patientId,
    required super.date,
    required super.time,
    super.reason,
    super.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctorId: json['doctorId'],
      // patientId: json['patientId'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
      reason: json['reason'],
      status: json['status'] != null
          ? AppointmentStatus.values[json['status']]
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      // 'patientId': patientId,
      'date': date.toIso8601String(),
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
      'reason': reason,
      'status': status?.index,
    };
  }
}
