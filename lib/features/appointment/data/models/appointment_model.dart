import '../../domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.id,
    required super.doctorId,
    required super.date,
    required super.time,
    super.reason,
    super.status,
  });

  factory AppointmentModel.fromEntity(Appointment entity) {
    return AppointmentModel(
      id: entity.id,
      doctorId: entity.doctorId,
      date: entity.date,
      time: entity.time,
      reason: entity.reason,
      status: entity.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'date': date.toIso8601String(),
      'hour': time.hour,
      'minute': time.minute,
      'reason': reason,
      'status': status?.name,
    };
  }
}
