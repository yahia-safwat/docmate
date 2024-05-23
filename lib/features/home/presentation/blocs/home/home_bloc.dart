import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/enums/doctor_category.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../doctor/domain/entities/doctor.dart';
import '../../../../doctor/domain/usecases/fetch_doctor_categories.dart';
import '../../../../doctor/domain/usecases/fetch_doctors.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchDoctorCategoriesUseCase fetchDoctorCategoriesUseCase;
  final FetchDoctorsUseCase fetchDoctorsUseCase;
  HomeBloc({
    required this.fetchDoctorCategoriesUseCase,
    required this.fetchDoctorsUseCase,
  }) : super(const _Initial()) {
    on<_LoadHome>(_onLoadHome);
  }

  Future<void> _onLoadHome(
    _LoadHome event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeState.loading());

    final categoriesResult = await fetchDoctorCategoriesUseCase(NoParams());
    final doctorsResult = await fetchDoctorsUseCase(NoParams());

    categoriesResult.fold(
      (failure) {
        emit(const HomeState.error('Error loading data'));
      },
      (doctorCategories) async {
        doctorsResult.fold(
          (failure) {
            emit(const HomeState.error('Error loading data'));
          },
          (doctors) {
            emit(HomeState.loaded(
              doctorCategories: doctorCategories,
              nearbyDoctors: doctors,
              myAppointments: [],
            ));
          },
        );
      },
    );
  }
}
