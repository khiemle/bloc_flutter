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

  CharactersBloc() {
    print("Construct InfiniteListBloc");
    marvelRepository = RemoteMarvelRepository();
  }

  @override
  CharactersState get initialState => Uninitialized();


  final StreamTransformer<List<Hero>, CharactersState> charactersStateTransform = StreamTransformer<List<Hero>, CharactersState>.fromHandlers(handleData: (heroes, sink){
      sink.add(Loaded(heroes: heroes));
  });

  @override
  Stream<CharactersState> mapEventToState(
      CharactersState currentState, CharactersEvent event) {
    if (event is Fetch) {
      try {
        return marvelRepository.getHeroesStream(20, 0).transform(charactersStateTransform);
      } catch (_) {
        final StreamController<CharactersState> ctrl = new StreamController();
        ctrl.sink.add(Error());
        return ctrl.stream;
      }
    }
    return Stream.empty();
  }
}
