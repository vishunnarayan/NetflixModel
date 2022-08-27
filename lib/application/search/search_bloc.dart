import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:netflix_model/domain/downloads/i_download_repo.dart';
import 'package:netflix_model/domain/downloads/models/downloads.dart';
import 'package:netflix_model/domain/search/model/search_response/search_response.dart';
import 'package:netflix_model/domain/search/search_service.dart';
import 'package:netflix_model/infrastructure/downloads_repository.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadsRepo _downloadService;
  final SearchService _searchService;
  SearchBloc(this._downloadService, this._searchService)
      : super(SearchState.initial()) {
    emit(const SearchState(
      searchResult: [],
      idleList: [],
      isloading: true,
      isError: false,
    ));
    on<Initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResult: [],
          idleList: state.idleList,
          isloading: false,
          isError: false,
        ));
        return;
      }
      //get trending
      final _result = await _downloadService.getDownloadsImage();
      _result.fold((MainFailure f) {
        emit(const SearchState(
          searchResult: [],
          idleList: [],
          isloading: false,
          isError: true,
        ));
      }, (List<Downloads> list) {
        emit(SearchState(
          searchResult: [],
          idleList: list,
          isloading: false,
          isError: false,
        ));
      });
      //display on ui
      // emit(_state);
    });
    on<SearchMovie>((event, emit) async {
      //call search query api
      print('Searching for ${event.movieQuery}');
      emit(const SearchState(
        searchResult: [],
        idleList: [],
        isloading: true,
        isError: false,
      ));
      final _result =
          await _searchService.searchMovies(movieQuery: event.movieQuery);
      final _state = _result.fold((MainFailure f) {
        emit(const SearchState(
          searchResult: [],
          idleList: [],
          isloading: false,
          isError: true,
        ));
      }, (SearchResponse r) {
        emit(SearchState(
          searchResult: r.results,
          idleList: [],
          isloading: false,
          isError: false,
        ));
      });
      //print(_result);
      emit(_state);
      //display on ui
    });
  }
}
