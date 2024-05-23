part of 'doctor_details_bloc.dart';

@freezed
class DoctorDetailsEvent with _$DoctorDetailsEvent {
  const factory DoctorDetailsEvent.loadDoctorDetails(String doctorId) =
      _LoadDoctorDetails;
}
