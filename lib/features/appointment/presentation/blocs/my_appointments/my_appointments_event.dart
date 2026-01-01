import 'package:equatable/equatable.dart';

abstract class MyAppointmentsEvent extends Equatable {
  const MyAppointmentsEvent();

  @override
  List<Object?> get props => [];
}

class FetchMyAppointments extends MyAppointmentsEvent {}

class CancelAppointment extends MyAppointmentsEvent {
  final String id;

  const CancelAppointment({required this.id});

  @override
  List<Object?> get props => [id];
}
