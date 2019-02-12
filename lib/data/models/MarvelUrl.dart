import 'package:json_annotation/json_annotation.dart';

part 'MarvelUrl.g.dart';
@JsonSerializable()

class MarvelUrl {
  String type;
  String url;

  MarvelUrl(this.type, this.url);

  factory MarvelUrl.fromJson(Map<String, dynamic> json) => _$MarvelUrlFromJson(json);

}