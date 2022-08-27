import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_model/application/downloads/downloads_bloc.dart';
import 'package:netflix_model/application/fastLaugh/fastlaugh_bloc.dart';
import 'package:netflix_model/application/home_bloc/home_bloc.dart';
import 'package:netflix_model/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_model/application/search/search_bloc.dart';
//import 'dart:html';
import 'package:netflix_model/core/colors/colors.dart';
import 'package:netflix_model/domain/core/di/injectable.dart';
import 'package:netflix_model/presentation/main_page/widgets/screen_main_page.dart';
//import 'package:get_it/get_it_impl.dart';
//import 'package:get_it/get_it.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DownloadsBloc>()),
        BlocProvider(create: (context) => getIt<SearchBloc>()),
        BlocProvider(create: (context) => getIt<FastlaughBloc>()),
        BlocProvider(create: (context) => getIt<HotAndNewBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            textTheme: const TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white)),
            primarySwatch: Colors.blue,
            backgroundColor: backgroundColor),
        home: ScreenMainPage(),
      ),
    );
  }
}
