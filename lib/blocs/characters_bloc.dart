import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_demo/data/IMarvelRepository.dart';
import 'package:bloc_demo/data/RemoteMarvelRepository.dart';
import 'package:bloc_demo/data/models/Hero.dart';
import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {}

class Fetch extends CharactersEvent {
  @override
  String toString() => 'Fetch';
}

abstract class CharactersState extends Equatable {
  CharactersState([List props = const []]) : super(props);
}

class Uninitialized extends CharactersState {
  @override
  String toString() => "Uninitialized";
}

class Error extends CharactersState {
  @override
  String toString() => "Error";
}

class Loaded extends CharactersState {
  final List<Hero> heroes;

  Loaded({this.heroes}) : super([heroes]);

  @override
  String toString() => 'Loaded { heroes: ${heroes.length} }';

  Loaded copyWith({List<Hero> heroes}) {
    return Loaded(heroes: heroes ?? this.heroes);
  }
}

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  IMarvelRepository marvelRepository;
  static const PAGE_SIZE = 20;

  CharactersBloc() {
    print("Construct InfiniteListBloc");
    marvelRepository = RemoteMarvelRepository();
  }

  @override
  CharactersState get initialState => Uninitialized();

  final StreamTransformer<List<Hero>, CharactersState>
      charactersStateTransform =
      StreamTransformer<List<Hero>, CharactersState>.fromHandlers(
          handleData: (heroes, sink) {
    sink.add(Loaded(heroes: heroes));
  });

  @override
  Stream<CharactersState> mapEventToState(
      CharactersState currentState, CharactersEvent event) async* {
    if (event is Fetch) {
      try {
        if (currentState is Uninitialized) {
          yield* marvelRepository
              .getHeroesStream(PAGE_SIZE, 0)
              .transform(charactersStateTransform);
        } else if (currentState is Loaded) {
          yield* marvelRepository
              .getHeroesStream(PAGE_SIZE, currentState.heroes.length)
              .map((remote) => currentState.heroes + remote)
              .transform(charactersStateTransform);
        }
      } catch (_) {
        yield Error();
      }
    }
  }
}
