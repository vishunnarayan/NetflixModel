part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    required List<SearchResult> searchResult,
    required List<Downloads> idleList,
    required bool isloading,
    required bool isError,
  }) = _SearchState;
  factory SearchState.initial() => const SearchState(
        searchResult: [],
        idleList: [],
        isloading: false,
        isError: false,
      );
}
