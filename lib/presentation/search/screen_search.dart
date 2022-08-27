import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/search/search_bloc.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/domain/core/debouncer/debouncer.dart';
import 'package:netflix_model/domain/downloads/models/downloads.dart';
import 'package:netflix_model/presentation/search/Widgets/search_idle_widget.dart';
import 'package:netflix_model/presentation/search/Widgets/search_result_widget.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 1000);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                backgroundColor: const Color.fromARGB(255, 75, 70, 70),
                style: const TextStyle(color: whiteColor),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.grey,
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    return;
                  }
                  _debouncer.run(() {
                    BlocProvider.of<SearchBloc>(context)
                        .add(SearchMovie(movieQuery: value));
                  });
                },
              ),
              kheight,
              Expanded(child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state.searchResult.isEmpty) {
                    return const SearchIdleWidget();
                  } else {
                    return const SearchResultWidget();
                  }
                },
              )),
              //Expanded(child: SearchResultWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
