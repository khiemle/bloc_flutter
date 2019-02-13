import 'package:bloc_demo/blocs/characters_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final charactersBloc = BlocProvider.of(context) as CharactersBloc;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new StreamBuilder(
              stream: charactersBloc.state,
              initialData: charactersBloc.initialState,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                final characterState = snapshot.data as CharactersState;
                if (characterState is Error || characterState is Uninitialized) {
                  return Text(
                    '${characterState.toString()}',
                    style: Theme.of(context).textTheme.display1,
                  );
                } else {
                  return Text(
                    '${characterState.toString()}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .display1,
                  );
                }
              }),
          RaisedButton(
            child: Text("Press"),
            onPressed: () => charactersBloc.dispatch(Fetch()),
          )
        ],
      ),
    );
  }
}
