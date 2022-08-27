import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/fastLaugh/fastlaugh_bloc.dart';
import 'package:netflix_model/presentation/fast%20Laugh/widgets/video_list_item.dart';

class ScreenFastLaugh extends StatelessWidget {
  const ScreenFastLaugh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<FastlaughBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(child: BlocBuilder<FastlaughBloc, FastlaughState>(
        builder: (context, state) {
          if (state.isloading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error while getting data'),
            );
          } else if (state.videoList.isEmpty) {
            return const Center(
              child: Text('Video List is empty'),
            );
          } else {
            return PageView(
              scrollDirection: Axis.vertical,
              children: List.generate(
                state.videoList.length,
                (index) {
                  return VideoListItemInheritedWidget(
                      key: Key(index.toString()),
                      widget: VideoListItem(index: index),
                      movieData: state.videoList[index]);
                },
              ),
            );
          }
        },
      )),
    );
  }
}
