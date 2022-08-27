import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/search/search_bloc.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/core/strings.dart';
import 'package:netflix_model/presentation/search/Widgets/search_title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kheight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isloading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error while getting data from API'),
                );
              } else {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      final movie = state.idleList[index];
                      return TopSearchItemTile(
                          title: movie.title ?? 'No item provided',
                          imageUrl: movie.posterPath ?? '');
                    }),
                    separatorBuilder: ((context, index) => kheight20),
                    itemCount: state.idleList.length);
              }
            },
          ),
        ),
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * .35,
          height: 65,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("$imageAppendUrl$imageUrl")),
          ),
        ),
        kwidth,
        Expanded(
            child: Text(
          title,
          style:
              const TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
        )),
        const Icon(
          CupertinoIcons.play_circle,
          color: whiteColor,
          size: 50,
        )
      ],
    );
  }
}
