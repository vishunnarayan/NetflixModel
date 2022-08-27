import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:netflix_model/domain/hot_and_new/hot_and_new_resp/hot_and_new_resp.dart';
import 'package:netflix_model/domain/hot_and_new/hot_and_new_service.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    //get home screen data

    on<GetHomeScreenData>((event, emit) async {
      //log('Getting Home screen data');
//sent loading to UI
      emit(
        state.copyWith(isLoading: true, hasError: false),
      );
//get Data

      final _movieResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTVData();
      // TODO: implement event handler

      // transform data
      final state1 = _movieResult.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southIndian = resp.results;
        //final trendingTv = resp.results;
        // final List<HotAndNewData> past = pastYear.shuffle();

        //trending != null ? trending.shuffle() : trending;
        //dramas.shuffle();

        //southIndian.shuffle;
        //southIndian.shuffle();
        //trendingTv!.shuffle();
        //dramas.shuffle();
        //pastYear.shuffle();
        //trending!.shuffle();
        //pastYear.shuffle();

        return HomeState(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear!,
          trendingMovieList: trending!,
          tenseDramaMovieList: dramas!,
          southIndianMovieList: southIndian!,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });
      emit(state1);
      //TV Result
      final state2 = _tvResult.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().microsecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramaMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final topTenList = resp.results;

        return HomeState(
            stateId: DateTime.now().microsecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramaMovieList: state.tenseDramaMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: topTenList!,
            isLoading: false,
            hasError: false);
      });
      emit(state2);
      // //
    });
  }
}
