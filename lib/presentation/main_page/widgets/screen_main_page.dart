import 'package:flutter/material.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/presentation/Downloads/screen_download.dart';
import 'package:netflix_model/presentation/fast%20Laugh/screen_fast_laugh.dart';
import 'package:netflix_model/presentation/home/screen_home.dart';
import 'package:netflix_model/presentation/main_page/widgets/bottom_nav.dart';
import 'package:netflix_model/presentation/new%20and%20hot/screen_new_and_hot.dart';
import 'package:netflix_model/presentation/new%20and%20hot/widgets/video_player.dart';
import 'package:netflix_model/presentation/search/screen_search.dart';
import 'package:video_player/video_player.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({Key? key}) : super(key: key);
  final List _pages = [
    const ScreenHome(),
    const ScreenNewAndHot(),
    const ScreenFastLaugh(),
    ScreenSearch(),
    ScreenDownload(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexNotifier,
            builder: (context, int newIndex, _) {
              return _pages[newIndex];
            }),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
