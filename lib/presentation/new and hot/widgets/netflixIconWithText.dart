import 'package:flutter/material.dart';
import 'package:netflix_model/core/constants.dart';

class NetflixIconWithText extends StatelessWidget {
  const NetflixIconWithText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: const Text(
            'N',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
        kwidth,
        const Text(
          'F I L M',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
