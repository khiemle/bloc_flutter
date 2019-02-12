import 'package:bloc_demo/blocs/counter_bloc.dart';
import 'package:bloc_demo/blocs/infinite_list_bloc.dart';
import 'package:bloc_demo/presentation/counter_page.dart';
import 'package:bloc_demo/blocs/simple_bloc_delegate.dart';
import 'package:bloc_demo/presentation/infinite_page.dart';
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

enum ScreenName {Counter, InfiniteList}

class _MyHomePageState extends State<MyHomePage> {

  CounterBloc counterBloc;
  InfiniteListBloc infiniteListBloc;
  var currentScreen = ScreenName.Counter;

  Bloc getCurrentBloc() {
    switch (currentScreen) {
      case ScreenName.Counter:
        if (counterBloc == null) counterBloc = CounterBloc();
        return counterBloc;
      case ScreenName.InfiniteList:
        if (infiniteListBloc == null) infiniteListBloc = InfiniteListBloc();
        return infiniteListBloc;
    }
    return null;
  }

  Widget getCurrentPage() {
    switch (currentScreen) {
      case ScreenName.Counter:
        return CounterPage();
      case ScreenName.InfiniteList:
        return InfinitePage();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<Bloc>(
      bloc: getCurrentBloc(),
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('BLoC Demo'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Counter'),
                onTap: () {
                  setState(() {
                    currentScreen = ScreenName.Counter;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Infinite List'),
                onTap: () {
                  setState(() {
                    currentScreen = ScreenName.InfiniteList;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("BLoC Demo"),
        ),
        body: getCurrentPage(),
      ),
    );
  }
}
