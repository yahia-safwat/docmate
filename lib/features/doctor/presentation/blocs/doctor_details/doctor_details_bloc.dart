import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/doctor.dart';
import '../../../domain/usecases/fetch_doctor_by_id.dart';

part 'doctor_details_event.dart';
part 'doctor_details_state.dart';
part 'doctor_details_bloc.freezed.dart';

class DoctorDetailsBloc extends Bloc<DoctorDetailsEvent, DoctorDetailsState> {
  final FetchDoctorByIdUseCase fetchDoctorByIdUseCase;
  DoctorDetailsBloc({required this.fetchDoctorByIdUseCase})
      : super(const DoctorDetailsState.initial()) {
    on<_LoadDoctorDetails>(_onDoctorDetailsEvent);
  }

  FutureOr<void> _onDoctorDetailsEvent(
    _LoadDoctorDetails event,
    Emitter<DoctorDetailsState> emit,
  ) async {
    emit(const DoctorDetailsState.loading());
    final doctorResult = await fetchDoctorByIdUseCase(event.doctorId);
    doctorResult.fold(
      (failure) {
        emit(const DoctorDetailsState.error(errMsg: 'Error loading data'));
      },
      (doctor) {
        emit(DoctorDetailsState.loaded(doctor: doctor));
      },
    );
  }
}
