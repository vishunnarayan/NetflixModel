import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget(
      {Key? key,
      required this.textOnIcon,
      required this.leftPosition,
      required this.iconToDisplay})
      : super(key: key);
  final String textOnIcon;
  final double leftPosition;
  final IconData iconToDisplay;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: leftPosition,
      //right: 250,
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(iconToDisplay),
            color: whiteColor,
          ),
          Text(
            textOnIcon,
            style: const TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
