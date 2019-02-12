import 'package:bloc_demo/blocs/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            new StreamBuilder(
                stream: counterBloc.state,
                initialData: counterBloc.initialState,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.display1,
                  );
                }),
            RaisedButton(
                child: Text("Increase"),
                onPressed: () => counterBloc.dispatch(CounterEvent.increment)
            )
          ],
        ),
      );
  }
}