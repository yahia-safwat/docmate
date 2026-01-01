import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'appointment_status.g.dart';

@HiveType(typeId: 1)
enum AppointmentStatus {
  @HiveField(0)
  pending(name: 'Pending', icon: Icons.pending),
  @HiveField(1)
  accepted(name: 'Accepted', icon: Icons.check),
  @HiveField(2)
  rejected(name: 'Rejected', icon: Icons.close),
  @HiveField(3)
  completed(name: 'Completed', icon: Icons.verified),
  @HiveField(4)
  cancelled(name: 'Cancelled', icon: Icons.cancel);

  final String name;
  final IconData icon;

  const AppointmentStatus({required this.name, required this.icon});
}
