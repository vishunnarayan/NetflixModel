import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_model/domain/hot_and_new/hot_and_new_resp/hot_and_new_resp.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_model/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/core/api_end_points.dart';

@LazySingleton(
  as: HotAndNewService,
)
class HotAndNewImplemantation implements HotAndNewService {
  @override
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewMovieData() async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.hotAndNewMovieUrl,
        //queryParameters: {'query': movieQuery},
      );
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResp.fromJson(response.data);
        //print(result.toString());
        return right(result);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      //log(e.toString());
      return left(const MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewTVData() async {
    try {
      final Response response = await Dio(BaseOptions()).get(
        ApiEndPoints.hotAndNewTvUrl,
        //queryParameters: {'query': movieQuery},
      );
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResp.fromJson(response.data);
        print(result.toString());
        return right(result);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      //log(e.toString());
      return left(const MainFailure.clientFailure());
    }
  }
}
