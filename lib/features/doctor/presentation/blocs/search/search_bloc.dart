import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../../domain/usecases/search_doctors_usecase.dart';
import '../../../domain/usecases/filter_doctors_usecase.dart';
import 'search_event.dart';
import 'search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDoctorsUseCase searchDoctors;
  final FilterDoctorsUseCase filterDoctors;

  SearchBloc({required this.searchDoctors, required this.filterDoctors})
    : super(const SearchState()) {
    on<SearchQueryChanged>(_onQueryChanged, transformer: debounce(_duration));
    on<SearchFilterApplied>(_onFilterApplied);
    on<SearchClearAll>(_onClearAll);
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      return emit(
        state.copyWith(status: SearchStatus.initial, doctors: [], query: ''),
      );
    }

    emit(state.copyWith(status: SearchStatus.loading, query: event.query));

    final result = await searchDoctors(event.query);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'Search failed',
        ),
      ),
      (doctors) =>
          emit(state.copyWith(status: SearchStatus.success, doctors: doctors)),
    );
  }

  Future<void> _onFilterApplied(
    SearchFilterApplied event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(status: SearchStatus.loading, filters: event.params));

    final result = await filterDoctors(event.params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SearchStatus.failure,
          errorMessage: 'Filtering failed',
        ),
      ),
      (doctors) =>
          emit(state.copyWith(status: SearchStatus.success, doctors: doctors)),
    );
  }

  void _onClearAll(SearchClearAll event, Emitter<SearchState> emit) {
    emit(const SearchState());
  }
}
