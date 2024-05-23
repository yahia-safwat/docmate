import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/enums/appointment_status.dart';

class Appointment extends Equatable {
  final String id;
  final String doctorId;
  // final String patientId;
  final DateTime date;
  final TimeOfDay time;
  final String? reason;
  final AppointmentStatus? status;

  const Appointment({
    required this.id,
    required this.doctorId,
    // required this.patientId,
    required this.date,
    required this.time,
    this.reason,
    this.status,
  });

  @override
  List<Object?> get props => [
        id,
        doctorId,
        // patientId,
        date,
        time,
        reason,
        status,
      ];
}
