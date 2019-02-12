import 'dart:async';
import 'package:bloc/bloc.dart';


enum InfiniteListEvent {
  increment,
  decrement
}

class InfiniteListBloc extends Bloc<InfiniteListEvent, int> {

  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(int currentState, InfiniteListEvent event) async* {
    switch (event) {
      case InfiniteListEvent.increment:
        yield currentState + 1;
        break;
      case InfiniteListEvent.decrement:
        yield currentState - 1;
        break;
    }
  }

  InfiniteListBloc() {
    print("Construct InfiniteListBloc");
  }

}