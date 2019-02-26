import 'package:flutter/material.dart';
import 'package:bloc_demo/data/models/Hero.dart' as Marvel;


class CharacterPage extends StatefulWidget {

  Marvel.Hero hero;


  CharacterPage(this.hero);

  @override
  _CharacterPageState createState() => _CharacterPageState(hero);
}

class _CharacterPageState extends State<CharacterPage> {

  Marvel.Hero hero;


  _CharacterPageState(this.hero);

  @override
  Widget build(BuildContext context) {
    double imageSize = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text(hero.name),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'image${hero.id}',
              child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    boxShadow: kElevationToShadow[6],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(hero.thumbnail.getPortraitUrl())),
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                hero.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
