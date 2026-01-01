import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/get_appointments_usecase.dart';
import '../../../domain/usecases/cancel_appointment_usecase.dart';
import 'my_appointments_event.dart';
import 'my_appointments_state.dart';

class MyAppointmentsBloc
    extends Bloc<MyAppointmentsEvent, MyAppointmentsState> {
  final GetAppointmentsUseCase getAppointments;
  final CancelAppointmentUseCase cancelAppointment;

  MyAppointmentsBloc({
    required this.getAppointments,
    required this.cancelAppointment,
  }) : super(MyAppointmentsInitial()) {
    on<FetchMyAppointments>(_onFetchAppointments);
    on<CancelAppointment>(_onCancelAppointment);
  }

  Future<void> _onFetchAppointments(
    FetchMyAppointments event,
    Emitter<MyAppointmentsState> emit,
  ) async {
    emit(MyAppointmentsLoading());
    final result = await getAppointments(NoParams());
    result.fold(
      (failure) => emit(
        const MyAppointmentsError(message: 'Failed to fetch appointments'),
      ),
      (appointments) => emit(MyAppointmentsLoaded(appointments: appointments)),
    );
  }

  Future<void> _onCancelAppointment(
    CancelAppointment event,
    Emitter<MyAppointmentsState> emit,
  ) async {
    final result = await cancelAppointment(event.id);
    result.fold(
      (failure) => emit(
        const MyAppointmentsError(message: 'Failed to cancel appointment'),
      ),
      (_) => add(FetchMyAppointments()),
    );
  }
}
