import 'package:flutter/material.dart';
import '../../domain/entities/doctor_working_hours.dart';

class DoctorWorkingHoursModel extends DoctorWorkingHours {
  const DoctorWorkingHoursModel({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.dayOfWeek,
  });

  factory DoctorWorkingHoursModel.fromJson(Map<String, dynamic> json) {
    return DoctorWorkingHoursModel(
      id: json['id'],
      startTime: TimeOfDay(
        hour: json['startTimeHour'],
        minute: json['startTimeMinute'],
      ),
      endTime: TimeOfDay(
        hour: json['endTimeHour'],
        minute: json['endTimeMinute'],
      ),
      dayOfWeek: json['dayOfWeek'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTimeHour': startTime.hour,
      'startTimeMinute': startTime.minute,
      'endTimeHour': endTime.hour,
      'endTimeMinute': endTime.minute,
      'dayOfWeek': dayOfWeek,
    };
  }

  DoctorWorkingHours toEntity() {
    return DoctorWorkingHours(
      id: id,
      startTime: startTime,
      endTime: endTime,
      dayOfWeek: dayOfWeek,
    );
  }
}
