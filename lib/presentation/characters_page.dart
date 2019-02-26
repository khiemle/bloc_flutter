import 'package:bloc_demo/blocs/characters_bloc.dart';
import 'package:bloc_demo/presentation/character_page.dart';
import 'package:bloc_demo/utils/MarvelUtils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bloc_demo/data/models/Hero.dart' as Marvel;

class CharactersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CharactersPageState();
}

class CharactersPageState extends State<CharactersPage> {
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

  CharactersPageState() {
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

  openHeroPage(Marvel.Hero hero) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterPage(hero)));
  }

  Widget _buildHeroesList(BuildContext context, List<Marvel.Hero> list) {
    Widget _buildRow(Marvel.Hero hero) {
      double leftWidth = MediaQuery.of(context).size.width * 0.25;
      double rightWidth = MediaQuery.of(context).size.width * 0.6;
      return GestureDetector(
        onTap: () => openHeroPage(hero),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 16.0),
              child: Hero(
                tag: 'image${hero.id}',
                child: Container(
                    width: leftWidth,
                    height: leftWidth,
                    decoration: new BoxDecoration(
                        boxShadow: kElevationToShadow[6],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(hero.thumbnail.getUrl())))),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  width: rightWidth,
                  child: RichText(
                    text: TextSpan(
                        text: hero.name,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 18,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch(
                                "${hero.resourceURI}${MarvelUtils.generateKeys()}");
                          }),
                  ),
                ),
                Container(
                  width: rightWidth,
                  child: Text(
                    hero.description,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.black87,
          ),
      itemCount: list.length,
      itemBuilder: (context, i) {
        return _buildRow(list[i]);
      },
      controller: _scrollController,
    );
  }
}
