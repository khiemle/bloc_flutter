import 'package:bloc_demo/data/responses/CharactersData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CharactersResponse.g.dart';

@JsonSerializable()
class CharactersResponse {
  CharactersData data;

  factory CharactersResponse.fromJson(Map<String, dynamic> json) =>
      _$CharactersResponseFromJson(json);

  CharactersResponse(this.data);
}
