import 'package:dartz/dartz.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:netflix_model/domain/search/model/search_response/search_response.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchResponse>> searchMovies(
      {required String movieQuery});
}
