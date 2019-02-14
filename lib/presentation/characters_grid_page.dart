import 'package:bloc_demo/blocs/characters_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_demo/data/models/Hero.dart' as Marvel;

class CharactersGridPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CharactersGridPageState();
}

class CharactersGridPageState extends State<CharactersGridPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  CharactersBloc charactersBloc;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      charactersBloc.dispatch(Fetch());
    }
  }

  CharactersGridPageState() {
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    charactersBloc = BlocProvider.of(context) as CharactersBloc;
    charactersBloc.dispatch(Fetch());
    return Center(
      child: StreamBuilder(
          stream: charactersBloc.state,
          initialData: charactersBloc.initialState,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final characterState = snapshot.data as CharactersState;
            if (characterState is Uninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (characterState is Error) {
              return Column(
                children: <Widget>[
                  Text(
                    '${characterState.toString()}',
                    style: Theme.of(context).textTheme.display1,
                  )
                ],
              );
            } else {
              return _buildHeroesList(
                  context, (snapshot.data as Loaded).heroes);
            }
          }),
    );
  }

  Widget _buildHeroesList(BuildContext context, List<Marvel.Hero> list) {
    Widget _buildCard(Marvel.Hero hero) {
      double itemWidth = MediaQuery.of(context).size.width * 0.5;
      return GestureDetector(
          onTap: () => {},
          child: Stack(children: <Widget>[
            Container(
                width: itemWidth,
                height: itemWidth,
                decoration: new BoxDecoration(
                    boxShadow: kElevationToShadow[6],
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(hero.thumbnail.getPortraitUrl())))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hero.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ]));
    }

    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _buildCard(list[i]);
      },
      controller: _scrollController,
    );
  }
}
