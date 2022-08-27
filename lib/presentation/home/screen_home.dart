import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/home_bloc/home_bloc.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/presentation/home/number_card.dart';
import 'package:netflix_model/presentation/home/numbered_card_top_ten.dart';
import 'package:netflix_model/presentation/search/Widgets/search_result_widget.dart';
import 'package:netflix_model/presentation/widgets/main_title.dart';
import 'package:netflix_model/presentation/widgets/main_card.dart';
import 'package:netflix_model/presentation/widgets/main_title_card_scroll.dart';
import 'package:netflix_model/presentation/widgets/smiley_icon.dart';

import '../../application/home_bloc/home_bloc.dart';
import '../widgets/icon_text_widget.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);
//ScrollDirection direction2 = ScrollDirection.idle;

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });

    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (context, dynamic, Widget? _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: ((notification) {
                  ScrollDirection direction = notification.direction;
                  direction != ScrollDirection.reverse
                      ? scrollNotifier.value = true
                      : scrollNotifier.value = false;
                  //print(direction);
                  return true;
                }),
                child: Stack(
                  children: [
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        );
                      } else if (state.hasError) {
                        return const Center(
                          child: Text('Error while getting data'),
                        );
                      }

                      final _releasedLastYr = state.pastYearMovieList
                          .map((m) {
                            return '$imageAppendUrl${m.posterPath}';
                          })
                          .toList()
                          .sublist(6);
                      final _trending = state.trendingMovieList.map((m) {
                        return '$imageAppendUrl${m.posterPath}';
                      }).toList();
                      //_trending..shuffle();

                      final _drama = state.tenseDramaMovieList
                          .map((m) {
                            return '$imageAppendUrl${m.posterPath}';
                          })
                          .toList()
                          .sublist(6);
                      final _southIndian = state.southIndianMovieList
                          .map((m) {
                            return '$imageAppendUrl${m.posterPath}';
                          })
                          .toList()
                          .sublist(2);
                      //_southIndian.shuffle();
                      // top 10 tv list

                      final topTenTv = state.trendingTvList.map((t) {
                        return '$imageAppendUrl${t.posterPath}';
                      }).toList();
                      final imageUrlHome = topTenTv[0];
                      //print("this is trial${topTenTv[0]}");

                      return ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 500,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(imageUrlHome),
                                    ),
                                  ),
                                ),
                                _playButton(),
                                const IconTextWidget(
                                  textOnIcon: 'Add to List',
                                  leftPosition: 20,
                                  iconToDisplay: Icons.add,
                                ),
                                const IconTextWidget(
                                  textOnIcon: 'Info',
                                  leftPosition: 280,
                                  iconToDisplay: Icons.info_outline_rounded,
                                )
                              ],
                            ),
                          ),
                          MainTitleCardHorizontalScrollWidget(
                            title: 'Released on Last Year',
                            posterList: _releasedLastYr,
                          ),
                          MainTitleCardHorizontalScrollWidget(
                            title: 'Trending Now',
                            posterList: _trending,
                          ),
                          NumberedCardTop10(postersList: topTenTv),
                          MainTitleCardHorizontalScrollWidget(
                            title: 'Tense Dramas',
                            posterList: _drama,
                          ),
                          MainTitleCardHorizontalScrollWidget(
                            title: 'SouthIndian Cinemas',
                            posterList: _southIndian,
                          ),
                        ],
                      );
                    }),
                    scrollNotifier.value == true
                        ? AnimatedContainer(
                            duration: const Duration(microseconds: 5500),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'N',
                                        style: TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                    ),
                                    kwidth,
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Icon(
                                              Icons.cast,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                            kwidth,
                                            SmileyIcon()
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      'TV Shows',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      'Movies',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      'Categories',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            width: double.infinity,
                            height: 80,
                            color: Colors.black.withOpacity(.2),
                          )
                        : kheight
                  ],
                ),
              );
            }));
  }

  Positioned _playButton() {
    return Positioned(
      //top: 0,
      left: 150,
      bottom: 1,
      right: 150,
      child: TextButton.icon(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(whiteColor),
          ),
          icon: const Icon(
            Icons.play_arrow,
            color: Colors.black,
          ),
          label: const Text(
            'Play',
            style: TextStyle(color: Colors.black),
          )),
    );
  }
}
