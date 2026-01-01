import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/booking_repository.dart';

class GetAvailableSlotsUseCase
    implements UseCase<List<TimeOfDay>, GetAvailableSlotsParams> {
  final BookingRepository repository;

  GetAvailableSlotsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<TimeOfDay>>> call(
    GetAvailableSlotsParams params,
  ) async {
    return await repository.getAvailableSlots(
      doctorId: params.doctorId,
      date: params.date,
    );
  }
}

class GetAvailableSlotsParams {
  final String doctorId;
  final DateTime date;

  const GetAvailableSlotsParams({required this.doctorId, required this.date});
}
