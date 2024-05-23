part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.loaded({
    required List<DoctorCategory> doctorCategories,
    required List<Doctor> nearbyDoctors,
    required List myAppointments,
  }) = _Loaded;

  const factory HomeState.error(message) = _Error;
}
