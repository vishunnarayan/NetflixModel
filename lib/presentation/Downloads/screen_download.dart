//import 'dart:html';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/downloads/downloads_bloc.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';
import 'package:netflix_model/infrastructure/downloads_repository.dart';
import 'package:netflix_model/presentation/widgets/app_bar_widget.dart';

import '../../domain/downloads/models/downloads.dart';

class ScreenDownload extends StatelessWidget {
  ScreenDownload({Key? key}) : super(key: key);
  final _widgetList = [
    const SmartDownloads(),
    const Section2(),
    const Section3(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          child: AppBarWidget(
            title: 'Downloads',
          ),
          preferredSize: Size.fromHeight(30),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemBuilder: (cxt, index) => _widgetList[index],
              separatorBuilder: (cxt, index) => const SizedBox(
                    height: 20,
                  ),
              itemCount: _widgetList.length),
        ));
    //body: Text('Downloads'));
  }
}

class SmartDownloads extends StatelessWidget {
  const SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kwidth,
        Icon(
          Icons.settings,
          color: whiteColor,
        ),
        kwidth,
        Text('Smart Download')
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {Key? key,
      //required Size size,
      required this.movieList,
      this.angle = 0,
      required this.margin,
      required this.size})
      : super(key: key);

  final String movieList;
  final angle;
  final EdgeInsets margin;
  final Size size;
  @override
  Widget build(BuildContext context) {
    //final _size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          margin: margin,
          height: size.height,
          width: size.width,
          //color: blackColor,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(movieList),
            ),
          ),
        ),
      ),
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add($DownloadsEvent.getDownloadsImage());
    });
    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          'Introducing Downloads for you',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        kheight,
        kheight,
        const Text(
          'We will download a personalised selection of\n movies and shows for you, so there is\n always something to watch on your\n device',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
                height: _size.width * .9,
                width: _size.width,
                //color: blackColor,
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.withOpacity(.5),
                            radius: _size.width * .38,
                          ),
                          state.downloads.isNotEmpty
                              ? DownloadsImageWidget(
                                  movieList:
                                      '$imageAppendUrl${state.downloads[0].posterPath}',
                                  margin: const EdgeInsets.only(
                                      left: 160, bottom: 50, top: 40),
                                  angle: 20,
                                  size:
                                      Size(_size.width * .3, _size.width * .45))
                              : const Text('Null'),
                          state.downloads.isNotEmpty
                              ? DownloadsImageWidget(
                                  movieList:
                                      '$imageAppendUrl${state.downloads[1].posterPath}',
                                  margin: const EdgeInsets.only(
                                      right: 160, bottom: 50, top: 40),
                                  angle: -20,
                                  size:
                                      Size(_size.width * .3, _size.width * .45))
                              : const Text('Null'),
                          state.downloads.isNotEmpty
                              ? DownloadsImageWidget(
                                  movieList:
                                      '$imageAppendUrl${state.downloads[2].posterPath}',
                                  margin: const EdgeInsets.only(
                                      right: 0, bottom: 10, top: 20),
                                  size:
                                      Size(_size.width * .38, _size.width * .5))
                              : const Text('Null'),
                        ],
                      ));
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: () {},
              color: buttonColorBlue,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Setup',
                  style: TextStyle(
                      color: buttonColorWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        kheight,
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {},
          //minWidth: 300,
          color: buttonColorWhite,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See What you can Download',
              style: TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}
