import 'package:bloc_demo/blocs/counter_bloc.dart';
import 'package:bloc_demo/blocs/infinite_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfinitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final infiniteListBloc = BlocProvider.of(context) as InfiniteListBloc;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Infinite List',
          ),
          RaisedButton(
            child: Text("Press"),
            onPressed: () => {},
          )
        ],
      ),
    );
  }
}
