import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/doctor_address.dart';

class DoctorAddressModel extends DoctorAddress {
  const DoctorAddressModel({
    required super.id,
    required super.doctorId,
    required super.latitude,
    required super.longitude,
    required super.streetAddress,
    required super.streetNumber,
    required super.city,
    required super.state,
    required super.country,
    required super.postalCode,
  });

  LatLng get latLon => LatLng(latitude, longitude);

  DoctorAddressModel copyWith({
    String? id,
    String? doctorId,
    double? latitude,
    double? longitude,
    String? streetAddress,
    String? streetNumber,
    String? city,
    String? state,
    String? country,
    String? postalCode,
  }) {
    return DoctorAddressModel(
      id: id ?? this.id,
      doctorId: doctorId ?? this.doctorId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      streetAddress: streetAddress ?? this.streetAddress,
      streetNumber: streetNumber ?? this.streetNumber,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
    );
  }

  factory DoctorAddressModel.fromJson(Map<String, dynamic> json) {
    return DoctorAddressModel(
      id: json['id'],
      doctorId: json['doctorId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      streetAddress: json['streetAddress'],
      streetNumber: json['streetNumber'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'latitude': latitude,
      'longitude': longitude,
      'streetAddress': streetAddress,
      'streetNumber': streetNumber,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }

  DoctorAddress toEntity() {
    return DoctorAddress(
      id: id,
      doctorId: doctorId,
      latitude: latitude,
      longitude: longitude,
      streetAddress: streetAddress,
      streetNumber: streetNumber,
      city: city,
      state: state,
      country: country,
      postalCode: postalCode,
    );
  }
}
