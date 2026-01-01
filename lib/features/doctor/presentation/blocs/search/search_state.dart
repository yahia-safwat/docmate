import 'package:equatable/equatable.dart';
import '../../../domain/entities/doctor.dart';
import '../../../domain/usecases/filter_doctors_usecase.dart';

enum SearchStatus { initial, loading, success, failure }

class SearchState extends Equatable {
  final SearchStatus status;
  final List<Doctor> doctors;
  final String query;
  final FilterParams? filters;
  final String? errorMessage;

  const SearchState({
    this.status = SearchStatus.initial,
    this.doctors = const [],
    this.query = '',
    this.filters,
    this.errorMessage,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<Doctor>? doctors,
    String? query,
    FilterParams? filters,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      doctors: doctors ?? this.doctors,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, doctors, query, filters, errorMessage];
}
