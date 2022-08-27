import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_model/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/presentation/new%20and%20hot/widgets/netflixIconWithText.dart';
import 'package:netflix_model/presentation/new%20and%20hot/widgets/video_player.dart';
import 'package:netflix_model/presentation/search/Widgets/search_result_widget.dart';
import 'package:netflix_model/presentation/widgets/app_bar_widget.dart';
import 'package:netflix_model/presentation/widgets/icon_text_widget.dart';
import 'package:netflix_model/presentation/widgets/main_title.dart';
import 'package:netflix_model/presentation/widgets/main_title_card_scroll.dart';
import 'package:netflix_model/presentation/widgets/smiley_icon.dart';
import 'package:video_player/video_player.dart';

import '../../application/fastLaugh/fastlaugh_bloc.dart';
import 'package:intl/intl.dart';

ValueNotifier<bool> videoPlayerNotifier = ValueNotifier(false);
// List hotAndNewWidgets = [
//   kheight,
//   const ImageWidgetforHotAndNew(),
//   const ImageWidgetforHotAndNew(),
// ];
// VideoPlayerController videoController =
//     VideoPlayerController.network('https://youtu.be/_EoLNs5m-7Y?t=4')
//       ..initialize();

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const HotAndNewEvent.loadDataInComingSoon());
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const HotAndNewEvent.loadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const HotAndNewEvent.loadDataInComingSoon());
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const HotAndNewEvent.loadDataInEveryoneIsWatching());
      },
      child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Scaffold(
            appBar: AppBar(
              title: const AppBarWidget(title: 'New And Hot'),
              backgroundColor: blackColor,
              bottom: TabBar(
                  unselectedLabelColor: whiteColor,
                  labelColor: blackColor,
                  automaticIndicatorColorAdjustment: true,
                  //indicatorColor: whiteColor,
                  indicator: BoxDecoration(
                    color: whiteColor,
                    //shape: BoxShape.circle,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  tabs: const [
                    SizedBox(
                      height: 35,
                      child: Center(
                        child: Text(
                          '🍿Coming Soon',
                          //style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          '👀Everyons watching',
                          //style: TextStyle(color: whiteColor),
                        ),
                      ),
                    )
                  ]),
            ),
            body: BlocBuilder<HotAndNewBloc, HotAndNewState>(
              builder: (context, state) {
                return TabBarView(children: [
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 20),
                      itemBuilder: (context, index) {
                        if (state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2));
                        } else if (state.hasError) {
                          return const Center(
                            child: Text('Error while getting data'),
                          );
                        } else if (state.comingSoonData.isEmpty) {
                          return const Center(
                            child: Text('Coming soon list is empty'),
                          );
                        } else {
                          final movie = state.comingSoonData[index];
                          final _date = DateTime.parse(movie.releaseDate!);
                          final formatedDate =
                              DateFormat.yMMMMd('en_US').format(_date);
                          //print(formatedDate);

                          return ImageWidgetforHotAndNew(
                            id: movie.id.toString(),
                            day: movie.releaseDate!.split('-')[2].substring(0),
                            month: formatedDate
                                .split(" ")
                                .first
                                .substring(0, 3)
                                .toUpperCase(),
                            movieName: movie.title ?? 'No Title',
                            posterPath: '$imageAppendUrl${movie.posterPath}',
                            movieDescription: movie.overview ?? 'No Overview',
                          );
                        }
                      },
                      separatorBuilder: (context, index) => kheight,
                      itemCount: state.comingSoonData.length), //Container(
                  // width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.width * .8,
                  // color: Colors.pink,
                  //),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 20),
                    itemBuilder: ((context, index) {
                      if (state.isLoading) {
                        return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2));
                      } else if (state.hasError) {
                        return const Center(
                          child: Text('Error while getting data'),
                        );
                      } else if (state.everyoneIsWatchingData.isEmpty) {
                        return const Center(
                          child: Text('Everyone is watching list is empty'),
                        );
                      } else {
                        final tv = state.everyoneIsWatchingData[index];

                        return EveryoneIsWatching(
                          id: tv.id.toString(),
                          movieName: tv.name ?? 'No Title',
                          posterPath: '$imageAppendUrl${tv.posterPath}',
                          movieDescription: tv.overview ?? 'No Overview',
                        );
                      }
                    }),
                    separatorBuilder: (context, index) => kheight,
                    itemCount: state.everyoneIsWatchingData.length,
                  )
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ImageWidgetforHotAndNew extends StatelessWidget {
  final String? month;
  final String day;
  final String id;
  final String posterPath;
  final String movieName;
  final String movieDescription;

  const ImageWidgetforHotAndNew(
      {Key? key,
      required this.id,
      required this.day,
      required this.month,
      required this.movieName,
      required this.posterPath,
      required this.movieDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    return Row(
      children: [
        SizedBox(
          height: 500,
          width: screenSize * .2,
          child: Column(
            children: [
              Text(
                month!,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                day,
                style:
                    const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: screenSize * .8,
                    child: Image(
                      image: NetworkImage(
                        posterPath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: backgroundColor.withOpacity(.6),
                      child: const Icon(
                        Icons.volume_off_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: 250,
                      child: Text(
                        movieName.toUpperCase(),
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        style: const TextStyle(
                            height: 1,
                            fontWeight: FontWeight.w800,
                            fontSize: 30),
                        //style: GoogleFonts.teko(fontSize: 30),
                      ),
                    ),
                  ),
                  //Spacer(),
                  const IconTextWidget(
                      textOnIcon: 'Remind Me',
                      leftPosition: 200,
                      iconToDisplay: CupertinoIcons.bell),
                  const IconTextWidget(
                      textOnIcon: 'info',
                      leftPosition: 0,
                      iconToDisplay: Icons.info_outline_rounded)
                ],
              ),
              kheight,
              Text(
                'Coming on $day $month',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const NetflixIconWithText(),
              SizedBox(
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kheight,
                    Text(
                      movieName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      movieDescription,
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          height: 500,
          width: screenSize * .75,
          //color: Colors.blue,
        )
      ],
    );
  }
}

class EveryoneIsWatching extends StatelessWidget {
  final String id;
  final String posterPath;
  final String movieName;
  final String movieDescription;

  const EveryoneIsWatching(
      {Key? key,
      required this.id,
      required this.movieName,
      required this.posterPath,
      required this.movieDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 200,
                width: screenSize,
                child: Image(
                  image: NetworkImage(
                    posterPath,
                  ),
                  loadingBuilder:
                      (BuildContext _, Widget child, ImageChunkEvent? process) {
                    if (process == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
                    return const Icon(
                      Icons.wifi,
                      color: Colors.white,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: backgroundColor.withOpacity(.6),
                  child: const Icon(
                    Icons.volume_off_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 250,
                  child: Text(
                    movieName.toUpperCase(),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        height: 1, fontWeight: FontWeight.w800, fontSize: 30),
                    //style: GoogleFonts.teko(fontSize: 30),
                  ),
                ),
              ),
              //Spacer(),
              const IconTextWidget(
                  textOnIcon: 'Share',
                  leftPosition: 200,
                  iconToDisplay: CupertinoIcons.paperplane),
              const IconTextWidget(
                  textOnIcon: 'My List',
                  leftPosition: 0,
                  iconToDisplay: Icons.add),
              const IconTextWidget(
                  textOnIcon: 'Play',
                  leftPosition: 0,
                  iconToDisplay: Icons.play_arrow),
            ],
          ),
          kheight,
          const SizedBox(
            height: 5,
          ),
          const NetflixIconWithText(),
          SizedBox(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight,
                Text(
                  movieName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  movieDescription,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          )
        ],
      ),
      height: 465,
      width: screenSize * .75,
      //color: Colors.blue,
    );
  }
}

class EveryoneIsWatching1 extends StatelessWidget {
  const EveryoneIsWatching1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        //height: 500,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  child: Image(
                    image: const NetworkImage(
                      everyoneWatchingMovieURL,
                    ),
                    loadingBuilder: (BuildContext _, Widget child,
                        ImageChunkEvent? progress) {
                      if (progress == null) {
                        return child;
                      } else {
                        return const CircularProgressIndicator(
                          strokeWidth: 2,
                        );
                      }
                    },
                    errorBuilder:
                        (BuildContext _, Object a, StackTrace? trace) {
                      return const Icon(
                        Icons.wifi,
                        color: Colors.white,
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: backgroundColor.withOpacity(.6),
                    child: const Icon(
                      Icons.volume_off_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    movieName.toUpperCase(),
                    style: GoogleFonts.teko(fontSize: 40),
                  ),
                ),
                const Spacer(),
                const IconTextWidget(
                    textOnIcon: 'Share',
                    leftPosition: 200,
                    iconToDisplay: CupertinoIcons.paperplane),
                const IconTextWidget(
                    textOnIcon: 'My List',
                    leftPosition: 0,
                    iconToDisplay: Icons.add),
                const IconTextWidget(
                    textOnIcon: 'Play',
                    leftPosition: 0,
                    iconToDisplay: Icons.play_arrow),
              ],
            ),
            kheight,
            const SizedBox(
              height: 5,
            ),
            const NetflixIconWithText(),
            SizedBox(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  kheight,
                  Text(
                    movieName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    movieOverview,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
          ],
        ),

        //color: Colors.blue,
      ),
    );
  }
}

// class ComingSoonLIst extends StatelessWidget {
//   const ComingSoonLIst({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HotAndNewBloc, HotAndNewState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(child: CircularProgressIndicator(strokeWidth: 2));
//         } else if (state.hasError) {
//           return const Center(
//             child: Text('Error while getting data'),
//           );
//         } else if (state.comingSoonData.isEmpty) {
//           return const Center(
//             child: Text('Coming soon list is empty'),
//           );
//         } else {
//           return ListView.separated(
//             itemBuilder: (context, index) {
//               final movie = state.comingSoonData[index];
//             },
//             separatorBuilder: (context, index) => kheight,
//             itemCount: state.comingSoonData.length,
//           );
//         }
//       },
//     );
//   }
// }
