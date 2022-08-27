import 'dart:ui';

import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_model/core/colors/colors.dart';

import '../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({Key? key, required this.index, required this.imageUrl})
      : super(key: key);
  final int index;
  final imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              height: 150,
              width: 40,
            ),
            Container(
              //margin: EdgeInsets.only(right: 0),
              height: 250,
              width: 150,
              //color: Colors.red,
              decoration: BoxDecoration(
                  // boxShadow: const [
                  //   BoxShadow(
                  //     offset: Offset(0, 15),
                  //     blurRadius: 10,
                  //     color: Colors.black,
                  //     spreadRadius: 18,
                  //   ),
                  // ],
                  borderRadius: kRadius,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        imageUrl,
                      ))),
            ),
          ],
        ),
        Positioned(
          left: -15,
          bottom: 0,
          top: 70,
          child: BorderedText(
            strokeColor: Colors.white,
            strokeWidth: 6,
            child: Text(
              //GoogleFonts(),
              '${index + 1}',
              style: const TextStyle(
                  fontSize: 130,
                  fontWeight: FontWeight.bold,
                  color: blackColor),
            ),
          ),
        )
      ],
    );
  }
}
