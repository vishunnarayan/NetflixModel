import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/home_bloc/home_bloc.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/presentation/widgets/main_card.dart';
import 'package:netflix_model/presentation/widgets/main_title.dart';

class MainTitleCardHorizontalScrollWidget extends StatelessWidget {
  final String title;
  final List<String> posterList;
  const MainTitleCardHorizontalScrollWidget({
    Key? key,
    required this.title,
    required this.posterList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(title: title),
          kheight,
          LimitedBox(
            maxHeight: 200,
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  10,
                  (index) => HomeMainCard(
                    imageUrl: posterList[index],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
