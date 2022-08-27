import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/presentation/widgets/app_bar_widget.dart';

const bool clicked = false;
Color containerColor = Colors.red;
ValueNotifier<bool> clickNotifier = ValueNotifier(false);

class TabBarNewAndHot extends StatelessWidget {
  const TabBarNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const PreferredSize(
          child: AppBarWidget(title: 'New & Hot'),
          preferredSize: Size.fromHeight(100),
        ),
        body: Column(
          children: [
            kheight20,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TabBar(
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
                          'Coming Soon',
                          //style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child: Center(
                        child: Text(
                          'Everyons watching',
                          //style: TextStyle(color: whiteColor),
                        ),
                      ),
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
