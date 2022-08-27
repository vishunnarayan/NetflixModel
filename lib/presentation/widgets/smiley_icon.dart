import 'package:flutter/material.dart';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/core/constants.dart';

class SmileyIcon extends StatelessWidget {
  const SmileyIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.blue),
          width: 30,
          height: 30,
          //color: Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: const [
              CircleAvatar(
                backgroundColor: whiteColor,
                radius: 2,
              ),
              kwidth,
              CircleAvatar(
                backgroundColor: whiteColor,
                radius: 2,
              ),
            ],
          ),
        ),
        kheight,
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            " __",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
