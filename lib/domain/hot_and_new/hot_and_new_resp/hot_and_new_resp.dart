import 'package:json_annotation/json_annotation.dart';

part 'hot_and_new_resp.g.dart';

@JsonSerializable()
class HotAndNewResp {
  List<HotAndNewData>? results;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_results')
  int? totalResults;

  HotAndNewResp({this.results, this.totalPages, this.totalResults});

  factory HotAndNewResp.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewRespToJson(this);
}

@JsonSerializable()
class HotAndNewData {
  @JsonKey(name: 'backdrop_path')
  String? backdropPath;
  int? id;
  String? overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'release_date')
  String? releaseDate;
  String? title;
  String? name;

  HotAndNewData(
      {this.backdropPath,
      this.id,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.name});

  factory HotAndNewData.fromJson(Map<String, dynamic> json) {
    return _$HotAndNewDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HotAndNewDataToJson(this);
}
