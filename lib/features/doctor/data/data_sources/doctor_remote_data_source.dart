import 'package:flutter/material.dart';

import '../../../../core/enums/consultation_mode.dart';
import '../../../../core/enums/doctor_category.dart';
import '../models/doctor_address_model.dart';
import '../models/doctor_model.dart';
import '../models/doctor_package_model.dart';
import '../models/doctor_working_hours_model.dart';

abstract class DoctorRemoteDataSource {
  Future<List<DoctorCategory>> getDoctorCategories();
  Future<List<DoctorModel>> getDoctors();
  Future<List<DoctorModel>> getDoctorsByCategory(String categoryId);
  Future<DoctorModel> getDoctorById(String doctorId);
}

class DoctorRemoteDataSourceImpl implements DoctorRemoteDataSource {
  @override
  Future<List<DoctorCategory>> getDoctorCategories() async {
    // Fetch doctor categories from a remote API or database
    return DoctorCategory.values;
  }

  @override
  Future<List<DoctorModel>> getDoctors() async {
    // Fetch doctors from a remote API or database
    return sampleDoctors;
  }

  @override
  Future<List<DoctorModel>> getDoctorsByCategory(String categoryId) async {
    // Fetch doctors by category from a remote API or database
    return sampleDoctors;
  }

  @override
  Future<DoctorModel> getDoctorById(String doctorId) async {
    // Fetch a doctor by ID from a remote API or database
    return sampleDoctors.firstWhere((doctor) => doctor.id == doctorId);
  }
}

final sampleDoctors = [
  DoctorModel(
    id: '1',
    name: 'Dr. John Doe',
    bio:
        'Dr. John Doe is a cardiologist in New York, New York and is affiliated with multiple hospitals in the area, including Lenox Hill Hospital and NYU Langone Hospitals. He received his medical degree from University of California San Francisco School of Medicine and has been in practice between 11-20 years. He is one of 102 doctors at Lenox Hill Hospital and one of 102 at NYU Langone Hospitals who specialize in Cardiovascular Disease.',
    profileImageUrl:
        'https://images.unsplash.com/photo-1557683316-973673baf926',
    category: DoctorCategory.familyMedicine,
    address: sampleAddresses[0],
    packages: samplePackages,
    workingHours: sampleDoctorWorkingHours,
    rating: 4.5,
    reviewCount: 100,
    patientCount: 1000,
  ),
  DoctorModel(
    id: '2',
    name: 'Dr. Jane Doe',
    bio: 'Dentist',
    profileImageUrl:
        'https://images.unsplash.com/photo-1557683316-973673baf926',
    category: DoctorCategory.generalSurgery,
    address: sampleAddresses[0],
    packages: samplePackages,
    workingHours: sampleDoctorWorkingHours,
    rating: 4.5,
    reviewCount: 100,
    patientCount: 1000,
  ),
];

const sampleAddresses = [
  DoctorAddressModel(
    id: '1',
    doctorId: '1',
    latitude: 25.276987,
    longitude: 55.296249,
    // latLon: LatLng(25.276987, 55.296249),
    streetAddress: 'Al Maktoum Street',
    streetNumber: '123',
    city: 'Dubai',
    state: 'Dubai',
    country: 'United Arab Emirates',
    postalCode: '12345',
  ),
];

const samplePackages = [
  DoctorPackageModel(
    id: '1',
    doctorId: '1',
    packageName: 'Basic',
    description: 'Basic consultation package',
    duration: Duration(minutes: 30),
    price: 100,
    consultationMode: ConsultationMode.video,
  ),
  DoctorPackageModel(
    id: '2',
    doctorId: '1',
    packageName: 'Standard',
    description: 'Standard consultation package',
    duration: Duration(minutes: 60),
    price: 200,
    consultationMode: ConsultationMode.inPerson,
  ),
  DoctorPackageModel(
    id: '3',
    doctorId: '1',
    packageName: 'Premium',
    description: 'Premium consultation package',
    duration: Duration(minutes: 90),
    price: 300,
    consultationMode: ConsultationMode.video,
  ),
];

const sampleDoctorWorkingHours = [
  DoctorWorkingHoursModel(
    id: '1',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Monday',
  ),
  DoctorWorkingHoursModel(
    id: '2',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Tuesday',
  ),
  DoctorWorkingHoursModel(
    id: '3',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Wednesday',
  ),
  DoctorWorkingHoursModel(
    id: '4',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Thursday',
  ),
  DoctorWorkingHoursModel(
    id: '5',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Friday',
  ),
  DoctorWorkingHoursModel(
    id: '6',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Saturday',
  ),
  DoctorWorkingHoursModel(
    id: '7',
    startTime: TimeOfDay(hour: 8, minute: 0),
    endTime: TimeOfDay(hour: 12, minute: 0),
    dayOfWeek: 'Sunday',
  ),
];
