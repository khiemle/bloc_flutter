import 'dart:async';

import 'package:bloc_demo/data/models/Hero.dart';


abstract class IMarvelRepository {
  Future<List<Hero>> getHeroes(int limit, int offset);
  Stream<List<Hero>> getHeroesStream(int limit, int offset);
}