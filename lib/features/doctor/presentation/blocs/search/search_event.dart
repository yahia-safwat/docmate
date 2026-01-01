import 'package:equatable/equatable.dart';
import '../../../domain/usecases/filter_doctors_usecase.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchQueryChanged extends SearchEvent {
  final String query;
  const SearchQueryChanged(this.query);

  @override
  List<Object?> get props => [query];
}

class SearchFilterApplied extends SearchEvent {
  final FilterParams params;
  const SearchFilterApplied(this.params);

  @override
  List<Object?> get props => [params];
}

class SearchClearAll extends SearchEvent {}
