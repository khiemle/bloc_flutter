import 'package:bloc_demo/data/models/MarvelImage.dart';
import 'package:bloc_demo/data/models/MarvelUrl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Hero.g.dart';

@JsonSerializable()

class Hero {
  int id;
  MarvelImage thumbnail;
  String name, description, modified, resourceURI;

  List<MarvelUrl> urls;

  Hero(this.id, this.thumbnail, this.name, this.description, this.modified,
      this.resourceURI, this.urls);

  factory Hero.fromJson(Map<String, dynamic> json) => _$HeroFromJson(json);

}