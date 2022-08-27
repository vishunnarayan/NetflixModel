import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/domain/core/api_end_points.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_model/domain/downloads/i_download_repo.dart';
import 'package:netflix_model/domain/downloads/models/downloads.dart';
//import 'package:get_it/get_it_impl.dart';

@LazySingleton(as: IDownloadsRepo)
class DownloadsRepository implements IDownloadsRepo {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImage() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.downloadsUrl);
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final downloads = (response.data["results"] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();
        print(downloads);
        return right(downloads);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return left(const MainFailure.clientFailure());
    }
  }
}
