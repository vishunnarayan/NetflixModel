import 'package:dartz/dartz.dart';
import 'package:netflix_model/domain/core/failures/main_failure.dart';
import 'package:netflix_model/domain/hot_and_new/hot_and_new_resp/hot_and_new_resp.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewMovieData();
  Future<Either<MainFailure, HotAndNewResp>> getHotAndNewTVData();
}
