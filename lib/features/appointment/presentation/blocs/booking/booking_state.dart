import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/appointment.dart';

enum BookingStatus {
  initial,
  loading,
  slotsLoaded,
  submitting,
  success,
  failure,
}

class BookingState extends Equatable {
  final BookingStatus status;
  final DateTime? selectedDate;
  final List<TimeOfDay> availableSlots;
  final TimeOfDay? selectedSlot;
  final Appointment? bookedAppointment;
  final String? errorMessage;

  const BookingState({
    this.status = BookingStatus.initial,
    this.selectedDate,
    this.availableSlots = const [],
    this.selectedSlot,
    this.bookedAppointment,
    this.errorMessage,
  });

  BookingState copyWith({
    BookingStatus? status,
    DateTime? selectedDate,
    List<TimeOfDay>? availableSlots,
    TimeOfDay? selectedSlot,
    Appointment? bookedAppointment,
    String? errorMessage,
  }) {
    return BookingState(
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      availableSlots: availableSlots ?? this.availableSlots,
      selectedSlot: selectedSlot ?? this.selectedSlot,
      bookedAppointment: bookedAppointment ?? this.bookedAppointment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedDate,
    availableSlots,
    selectedSlot,
    bookedAppointment,
    errorMessage,
  ];
}
