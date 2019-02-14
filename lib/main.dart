import 'package:bloc_demo/blocs/counter_bloc.dart';
import 'package:bloc_demo/blocs/characters_bloc.dart';
import 'package:bloc_demo/presentation/characters_grid_page.dart';
import 'package:bloc_demo/presentation/counter_page.dart';
import 'package:bloc_demo/blocs/simple_bloc_delegate.dart';
import 'package:bloc_demo/presentation/characters_page.dart';
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
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum ScreenName {Counter, CharactersList, CharactersGrid}

class _MyHomePageState extends State<MyHomePage> {

  CounterBloc counterBloc;
  CharactersBloc charactersListBloc;
  var currentScreen = ScreenName.Counter;

  Bloc getCurrentBloc() {
    switch (currentScreen) {
      case ScreenName.Counter:
        if (counterBloc == null) counterBloc = CounterBloc();
        return counterBloc;
      case ScreenName.CharactersList:
        if (charactersListBloc == null) charactersListBloc = CharactersBloc();
        return charactersListBloc;
      case ScreenName.CharactersGrid:
        if (charactersListBloc == null) charactersListBloc = CharactersBloc();
        return charactersListBloc;
    }
    return null;
  }

  Widget getCurrentPage() {
    switch (currentScreen) {
      case ScreenName.Counter:
        return CounterPage();
      case ScreenName.CharactersList:
        return CharactersPage();
      case ScreenName.CharactersGrid:
        return CharactersGridPage();
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
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                    child: Text('BLoC Demo', style: TextStyle(
                      color: Colors.white,
                    ),)
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  boxShadow:  kElevationToShadow[6]
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
                title: Text('Characters List'),
                onTap: () {
                  setState(() {
                    currentScreen = ScreenName.CharactersList;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Characters Grid'),
                onTap: () {
                  setState(() {
                    currentScreen = ScreenName.CharactersGrid;
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
