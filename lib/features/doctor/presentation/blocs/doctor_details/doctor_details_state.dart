part of 'doctor_details_bloc.dart';

@freezed
class DoctorDetailsState with _$DoctorDetailsState {
  const factory DoctorDetailsState.initial() = _Initial;
  const factory DoctorDetailsState.loading() = _Loading;
  const factory DoctorDetailsState.loaded({required Doctor doctor}) = _Loaded;
  const factory DoctorDetailsState.error({required String errMsg}) = _Error;
}
