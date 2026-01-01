import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class BookingDateChanged extends BookingEvent {
  final DateTime date;
  const BookingDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

class BookingSlotSelected extends BookingEvent {
  final TimeOfDay slot;
  const BookingSlotSelected(this.slot);

  @override
  List<Object?> get props => [slot];
}

class BookingSubmitted extends BookingEvent {
  final String doctorId;
  const BookingSubmitted({required this.doctorId});

  @override
  List<Object?> get props => [doctorId];
}
