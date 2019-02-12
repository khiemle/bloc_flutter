import 'package:json_annotation/json_annotation.dart';

part 'MarvelImage.g.dart';

@JsonSerializable()

class MarvelImage {
  String path;
  String extension;

  MarvelImage(this.path, this.extension);


  factory MarvelImage.fromJson(Map<String, dynamic> json) => _$MarvelImageFromJson(json);

  getUrl() => "$path/standard_medium.$extension";
  getPortraitUrl() => "$path/portrait_incredible.$extension";

}