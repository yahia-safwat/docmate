import 'package:equatable/equatable.dart';
import '../../../../core/enums/doctor_category.dart';
import 'doctor_address.dart';
import 'doctor_package.dart';
import 'doctor_working_hours.dart';

class Doctor extends Equatable {
  final String id;
  final String name;
  final String bio;
  final String profileImageUrl;
  final DoctorCategory category;
  final DoctorAddress address;
  final List<DoctorPackage> packages;
  final List<DoctorWorkingHours> workingHours;
  final double rating;
  final int reviewCount;
  final int patientCount;

  const Doctor({
    required this.id,
    required this.name,
    required this.bio,
    required this.profileImageUrl,
    required this.workingHours,
    required this.category,
    required this.address,
    required this.packages,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.patientCount = 0,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        bio,
        profileImageUrl,
        workingHours,
        category,
        address,
        packages,
        rating,
        reviewCount,
        patientCount,
      ];
}