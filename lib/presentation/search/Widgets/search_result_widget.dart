import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/search/search_bloc.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/presentation/search/Widgets/search_idle_widget.dart';
import 'package:netflix_model/presentation/search/Widgets/search_title.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'TV & Movies'),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.5,
                children: List.generate(state.searchResult.length, (index) {
                  final movie = state.searchResult[index];
                  return MainCard(
                      imageUrl: "$imageAppendUrl${movie.posterPath}");
                }),
              );
            },
          ),
        )
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  String imageUrl;
  MainCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            imageUrl,
          ),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
