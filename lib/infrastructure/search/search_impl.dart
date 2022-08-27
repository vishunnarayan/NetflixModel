import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/domain/core/api_end_points.dart';
import 'package:netflix_model/domain/downloads/models/downloads.dart';
import 'package:netflix_model/domain/search/model/search_response/search_response.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_model/domain/search/search_service.dart';

@LazySingleton(as: SearchService)
class SearchImpl implements SearchService {
  @override
  Future<Either<MainFailure, SearchResponse>> searchMovies(
      {required String movieQuery}) async {
    //String movieUrl = "${ApiEndPoints.searchUrl}$movieQuery";
    //print(movieUrl);
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.searchUrl,
        queryParameters: {'query': movieQuery},
      );
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = SearchResponse.fromJson(response.data);
        print(result.toString());
        return right(result);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return left(const MainFailure.clientFailure());
    }
  }
}
