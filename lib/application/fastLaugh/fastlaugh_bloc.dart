import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:netflix_model/domain/downloads/i_download_repo.dart';
import 'package:netflix_model/domain/downloads/models/downloads.dart';

part 'fastlaugh_event.dart';
part 'fastlaugh_state.dart';
part 'fastlaugh_bloc.freezed.dart';

final videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
];
ValueNotifier<Set<int>> likedVideoNotifier = ValueNotifier({});

@injectable
class FastlaughBloc extends Bloc<FastlaughEvent, FastlaughState> {
  FastlaughBloc(IDownloadsRepo downloadService)
      : super(FastlaughState.initial()) {
    on<Initialize>((event, emit) async {
      //send loading to UI
      emit(
        const FastlaughState(
          videoList: [],
          isloading: true,
          isError: false,
        ),
      );
      //get movie details
      final _result = await downloadService.getDownloadsImage();
      final _state = _result.fold((l) {
        return const FastlaughState(
          videoList: [],
          isloading: false,
          isError: true,
        );
      }, (resp) {
        return FastlaughState(
          videoList: resp,
          isloading: false,
          isError: false,
        );
      });
      emit(_state);
    });
    on<LikeVideo>((event, emit) async {
      likedVideoNotifier.value.add(event.id);
    });
    on<UnlikeVideo>((event, emit) async {
      likedVideoNotifier.value.remove(event.id);
    });
  }
}
