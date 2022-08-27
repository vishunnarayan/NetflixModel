import 'package:flutter/material.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/presentation/home/number_card.dart';
import 'package:netflix_model/presentation/widgets/main_title.dart';

class NumberedCardTop10 extends StatelessWidget {
  const NumberedCardTop10({
    Key? key,
    required this.postersList,
  }) : super(key: key);
  final List<String> postersList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(title: 'Top 10 TV & Movies in India'),
        kheight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              postersList.length,
              (index) => NumberCard(
                index: index,
                imageUrl: postersList[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
