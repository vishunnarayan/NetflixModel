import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/home_bloc/home_bloc.dart';

import '../../core/constants.dart';

class HomeMainCard extends StatelessWidget {
  final imageUrl;
  const HomeMainCard({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
        height: 250,
        width: 150,
        //color: Colors.red,
        decoration: BoxDecoration(
            borderRadius: kRadius,
            image: DecorationImage(
                image: NetworkImage(
              imageUrl,
              //'https://www.themoviedb.org/t/p/w1280/mtLk7vugGWtMkO913Fg8zfM1YET.jpg'
            ))),
      );
    });
  }
}
