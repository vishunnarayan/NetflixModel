part of 'fastlaugh_bloc.dart';

@freezed
class FastlaughState with _$FastlaughState {
  const factory FastlaughState({
    @Default([]) List<Downloads> videoList,
    required bool isloading,
    required bool isError,
  }) = _Initial;
  factory FastlaughState.initial() => const FastlaughState(
        videoList: [],
        isloading: true,
        isError: false,
      );
}
