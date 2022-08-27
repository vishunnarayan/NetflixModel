import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/fastLaugh/fastlaugh_bloc.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/domain/downloads/models/downloads.dart';
import 'package:netflix_model/presentation/search/Widgets/search_idle_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;
  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
    //required Widget widget,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = videoUrls[index % videoUrls.length];
    return Stack(
      children: [
        //Left Side
        FastLaughVIdeoPlayer(videoUrl: videoUrl, onStateChanged: (bools) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: blackColor.withOpacity(.7),
                  child: const Icon(Icons.volume_off_rounded),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage(
                                '$imageAppendUrl$posterPath',
                                //everyoneWatchingMovieURL,
                              ),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: likedVideoNotifier,
                        builder: (BuildContext cxt, Set<int> newLikedVideos,
                            Widget? _) {
                          final _index = index;
                          if (newLikedVideos.contains(_index)) {
                            return GestureDetector(
                              onTap: () {
                                //   BlocProvider.of<FastlaughBloc>(context)
                                //       .add(LikeVideo(id: _index));
                                likedVideoNotifier.value.remove(_index);
                                likedVideoNotifier.notifyListeners();
                              },
                              child: const VideoActionWidget(
                                  icon: Icons.emoji_emotions, title: 'LOL'),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              likedVideoNotifier.value.add(_index);
                              likedVideoNotifier.notifyListeners();
                            },
                            child: const VideoActionWidget(
                                icon: Icons.favorite_outline, title: 'LOL'),
                          );
                        }),
                    const VideoActionWidget(icon: Icons.add, title: 'My List'),
                    GestureDetector(
                      onTap: () {
                        Share.share(videoUrl);
                      },
                      child: const VideoActionWidget(
                          icon: CupertinoIcons.paperplane, title: 'Share'),
                    ),
                    const VideoActionWidget(
                        icon: CupertinoIcons.play_fill, title: 'Play')
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoActionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: whiteColor,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class FastLaughVIdeoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVIdeoPlayer({
    Key? key,
    required this.videoUrl,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<FastLaughVIdeoPlayer> createState() => _FastLaughVIdeoPlayerState();
}

class _FastLaughVIdeoPlayerState extends State<FastLaughVIdeoPlayer> {
  late VideoPlayerController _videoPlayerController;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {});
      //_videoPlayerController.initialize();
    });
    _videoPlayerController.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _videoPlayerController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ));
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
