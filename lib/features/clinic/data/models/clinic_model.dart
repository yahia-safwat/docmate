import '../../domain/entities/clinic.dart';

class ClinicModel extends Clinic {
  const ClinicModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
  });

  factory ClinicModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return ClinicModel(
      id: id ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
