import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/appointment.dart';
import '../../../domain/usecases/book_appointment_usecase.dart';
import '../../../domain/usecases/get_available_slots_usecase.dart';
import 'booking_event.dart';
import 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final GetAvailableSlotsUseCase getAvailableSlots;
  final BookAppointmentUseCase bookAppointment;

  BookingBloc({required this.getAvailableSlots, required this.bookAppointment})
    : super(const BookingState()) {
    on<BookingDateChanged>(_onDateChanged);
    on<BookingSlotSelected>(_onSlotSelected);
    on<BookingSubmitted>(_onSubmitted);
  }

  Future<void> _onDateChanged(
    BookingDateChanged event,
    Emitter<BookingState> emit,
  ) async {
    emit(
      state.copyWith(
        status: BookingStatus.loading,
        selectedDate: event.date,
        selectedSlot: null,
      ),
    );

    final result = await getAvailableSlots(
      GetAvailableSlotsParams(
        doctorId: 'mock_id', // This should be passed from UI
        date: event.date,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: 'Failed to load slots',
        ),
      ),
      (slots) => emit(
        state.copyWith(
          status: BookingStatus.slotsLoaded,
          availableSlots: slots,
        ),
      ),
    );
  }

  void _onSlotSelected(BookingSlotSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedSlot: event.slot));
  }

  Future<void> _onSubmitted(
    BookingSubmitted event,
    Emitter<BookingState> emit,
  ) async {
    if (state.selectedDate == null || state.selectedSlot == null) {
      emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: 'Please select a date and time slot',
        ),
      );
      return;
    }

    emit(state.copyWith(status: BookingStatus.submitting));

    final appointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      doctorId: event.doctorId,
      date: state.selectedDate!,
      time: state.selectedSlot!,
    );

    final result = await bookAppointment(appointment);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: 'Booking failed. Please try again.',
        ),
      ),
      (appointment) => emit(
        state.copyWith(
          status: BookingStatus.success,
          bookedAppointment: appointment,
        ),
      ),
    );
  }
}
