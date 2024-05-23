import 'package:equatable/equatable.dart';
import '../../../../core/enums/consultation_mode.dart';

class DoctorPackage extends Equatable {
  final String id;
  final String doctorId;
  final String packageName;
  final String description;
  final Duration duration;
  final double price;
  final ConsultationMode consultationMode;

  const DoctorPackage({
    required this.id,
    required this.doctorId,
    required this.packageName,
    required this.description,
    required this.duration,
    required this.price,
    required this.consultationMode,
  });

  @override
  List<Object?> get props => [
        id,
        doctorId,
        packageName,
        description,
        duration,
        price,
        consultationMode,
      ];
}
