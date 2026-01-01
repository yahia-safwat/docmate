import 'package:equatable/equatable.dart';
import '../../../domain/entities/appointment.dart';

abstract class MyAppointmentsState extends Equatable {
  const MyAppointmentsState();

  @override
  List<Object?> get props => [];
}

class MyAppointmentsInitial extends MyAppointmentsState {}

class MyAppointmentsLoading extends MyAppointmentsState {}

class MyAppointmentsLoaded extends MyAppointmentsState {
  final List<Appointment> appointments;

  const MyAppointmentsLoaded({required this.appointments});

  @override
  List<Object?> get props => [appointments];
}

class MyAppointmentsError extends MyAppointmentsState {
  final String message;

  const MyAppointmentsError({required this.message});

  @override
  List<Object?> get props => [message];
}
