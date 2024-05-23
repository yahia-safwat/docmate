import '../../../../core/enums/doctor_category.dart';
import '../../domain/entities/doctor.dart';
import 'doctor_address_model.dart';
import 'doctor_package_model.dart';
import 'doctor_working_hours_model.dart';

class DoctorModel extends Doctor {
  const DoctorModel({
    required super.id,
    required super.name,
    required super.bio,
    required super.profileImageUrl,
    required super.category,
    required super.address,
    required super.packages,
    required super.workingHours,
    super.rating,
    super.reviewCount,
    super.patientCount,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
      category: DoctorCategory.values[json['category']],
      address: DoctorAddressModel.fromJson(json['address']),
      packages: (json['packages'] as List)
          .map((e) => DoctorPackageModel.fromJson(e))
          .toList(),
      workingHours: (json['workingHours'] as List)
          .map((e) => DoctorWorkingHoursModel.fromJson(e))
          .toList(),
      rating: json['rating'] ?? 0.0,
      reviewCount: json['reviewCount'] ?? 0,
      patientCount: json['patientCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'category': category.index,
      'address': (address as DoctorAddressModel).toJson(),
      'packages':
          packages.map((e) => (e as DoctorPackageModel).toJson()).toList(),
      'workingHours': workingHours
          .map((e) => (e as DoctorWorkingHoursModel).toJson())
          .toList(),
      'rating': rating,
      'reviewCount': reviewCount,
      'patientCount': patientCount,
    };
  }

  Doctor toEntity() {
    return Doctor(
      id: id,
      name: name,
      bio: bio,
      profileImageUrl: profileImageUrl,
      category: category,
      address: (address as DoctorAddressModel).toEntity(),
      packages:
          packages.map((e) => (e as DoctorPackageModel).toEntity()).toList(),
      workingHours: workingHours
          .map((e) => (e as DoctorWorkingHoursModel).toEntity())
          .toList(),
      rating: rating,
      reviewCount: reviewCount,
      patientCount: patientCount,
    );
  }
}
