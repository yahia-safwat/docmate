import 'package:equatable/equatable.dart';

class DoctorAddress extends Equatable {
  final String id;
  final String doctorId;
  final double latitude;
  final double longitude;
  final String streetAddress;
  final String streetNumber;
  final String city;
  final String state;
  final String country;
  final String postalCode;

  const DoctorAddress({
    required this.id,
    required this.doctorId,
    required this.latitude,
    required this.longitude,
    required this.streetAddress,
    required this.streetNumber,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  @override
  List<Object?> get props => [
        id,
        doctorId,
        latitude,
        longitude,
        streetAddress,
        streetNumber,
        city,
        state,
        country,
        postalCode,
      ];
}
