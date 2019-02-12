import 'package:bloc_demo/data/IMarvelRepository.dart';
import 'package:bloc_demo/data/models/Hero.dart';
import 'package:bloc_demo/data/responses/CharactersResponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';


class RemoteMarvelRepository implements IMarvelRepository {
  final _baseUrl = 'https://gateway.marvel.com';
  final _publicKey = '263cd637da186059f47aec7176a0bf50';
  final _privateKey = '5eb3157a247739ebcc162105eddf4f310abb7db3';

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  @override
  Future<List<Hero>> getHeroes(int limit, int offset) async {

    final timeStamp = new DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5('$timeStamp$_privateKey$_publicKey');

    var response = await http.get('$_baseUrl/v1/public/characters?limit=$limit&offset=$offset&orderBy=-modified&ts=$timeStamp&apikey=$_publicKey&hash=$hash');
    Map charactersMap = jsonDecode(response.body);
    var charactersResponse = CharactersResponse.fromJson(charactersMap);
    return charactersResponse.data.results;
  }

  @override
  Stream<List<Hero>> getHeroesStream(int limit, int offset) async* {
    final timeStamp = new DateTime.now().millisecondsSinceEpoch;
    final hash = generateMd5('$timeStamp$_privateKey$_publicKey');

    var response = await http.get('$_baseUrl/v1/public/characters?limit=$limit&offset=$offset&orderBy=-modified&ts=$timeStamp&apikey=$_publicKey&hash=$hash');
    Map charactersMap = jsonDecode(response.body);
    var charactersResponse = CharactersResponse.fromJson(charactersMap);
    yield charactersResponse.data.results;
  }


}