part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required List<HotAndNewData> comingSoonData,
    required List<HotAndNewData> everyoneIsWatchingData,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;
  factory HotAndNewState.initial() => const HotAndNewState(
        comingSoonData: [],
        everyoneIsWatchingData: [],
        isLoading: false,
        hasError: false,
      );
}
