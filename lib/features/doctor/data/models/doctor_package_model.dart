import '../../../../core/enums/consultation_mode.dart';
import '../../domain/entities/doctor_package.dart';

class DoctorPackageModel extends DoctorPackage {
  const DoctorPackageModel({
    required super.id,
    required super.doctorId,
    required super.packageName,
    required super.description,
    required super.duration,
    required super.price,
    required super.consultationMode,
  });

  factory DoctorPackageModel.fromJson(Map<String, dynamic> json) {
    return DoctorPackageModel(
      id: json['id'],
      doctorId: json['doctorId'],
      packageName: json['packageName'],
      description: json['description'],
      duration: Duration(minutes: json['duration']),
      price: json['price'],
      consultationMode: ConsultationMode.values[json['consultationMode']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'packageName': packageName,
      'description': description,
      'duration': duration.inMinutes,
      'price': price,
      'consultationMode': consultationMode.index,
    };
  }

  DoctorPackage toEntity() {
    return DoctorPackage(
      id: id,
      doctorId: doctorId,
      packageName: packageName,
      description: description,
      duration: duration,
      price: price,
      consultationMode: consultationMode,
    );
  }
}
