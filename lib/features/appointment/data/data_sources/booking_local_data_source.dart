import 'package:hive_flutter/hive_flutter.dart';
import '../models/appointment_model.dart';

abstract class BookingLocalDataSource {
  Future<void> cacheAppointment(AppointmentModel appointment);
  Future<List<AppointmentModel>> getAppointments();
  Future<void> deleteAppointment(String id);
}

class BookingLocalDataSourceImpl implements BookingLocalDataSource {
  static const String boxName = 'appointments_box';

  @override
  Future<void> cacheAppointment(AppointmentModel appointment) async {
    final box = await Hive.openBox<AppointmentModel>(boxName);
    await box.put(appointment.id, appointment);
  }

  @override
  Future<List<AppointmentModel>> getAppointments() async {
    final box = await Hive.openBox<AppointmentModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> deleteAppointment(String id) async {
    final box = await Hive.openBox<AppointmentModel>(boxName);
    await box.delete(id);
  }
}
