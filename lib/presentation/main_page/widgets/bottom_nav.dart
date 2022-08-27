import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_model/core/colors/colors.dart';

final ValueNotifier<int> indexNotifier = ValueNotifier(0);

// ignore: must_be_immutable
class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);
  //final ValueNotifier<int> indexNotifier = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexNotifier,
      builder: (BuildContext context, int newIndex, widget_) {
        return BottomNavigationBar(
          currentIndex: newIndex,

          type: BottomNavigationBarType.fixed,

          fixedColor: Colors.white,
          backgroundColor: backgroundColor,
          //selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: const IconThemeData(color: Colors.white),
          unselectedIconTheme: const IconThemeData(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.collections_bookmark_outlined),
                label: 'New & Hot'),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions), label: 'Fast Laugh'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.download_rounded), label: 'Downloads'),
          ],
          onTap: (value) {
            newIndex = value;
            indexNotifier.value = newIndex;
            // print(newIndex);
          },
        );
      },
    );
  }
}
