import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  List<SearchResult> results;

  SearchResponse({
    this.results = const [],
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return _$SearchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class SearchResult {
  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  SearchResult({
    this.originalTitle,
    this.posterPath,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return _$SearchResultFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
