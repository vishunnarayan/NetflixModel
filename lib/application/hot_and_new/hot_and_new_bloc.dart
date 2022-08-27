import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:netflix_model/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/hot_and_new_resp/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      //get data from remote

      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //data to state

      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
              comingSoonData: [],
              everyoneIsWatchingData: [],
              isLoading: false,
              hasError: true);
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonData: resp.results!,
            everyoneIsWatchingData: state.everyoneIsWatchingData,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      //get data from remote

      final _result = await _hotAndNewService.getHotAndNewTVData();

      //data to state

      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
              comingSoonData: [],
              everyoneIsWatchingData: [],
              isLoading: false,
              hasError: true);
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonData: state.comingSoonData,
            everyoneIsWatchingData: resp.results!,
            isLoading: false,
            hasError: false,
          );
        },
      );
      emit(newState);
    });
  }
}
