import 'package:bloc_demo/blocs/counter_bloc.dart';
import 'package:bloc_demo/presentation/counter_page.dart';
import 'package:bloc_demo/blocs/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterBloc counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      bloc: counterBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text("BLoC Demo"),
        ),
        body: CounterPage(),
      ),
    );
  }
}
