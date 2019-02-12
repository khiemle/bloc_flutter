import 'package:bloc_demo/data/models/Hero.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CharactersData.g.dart';

@JsonSerializable()
class CharactersData {
  List<Hero> results;

  factory CharactersData.fromJson(Map<String, dynamic> json) => _$CharactersDataFromJson(json);

  CharactersData(this.results);
}
