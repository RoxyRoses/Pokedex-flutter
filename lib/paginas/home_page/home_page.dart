import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/paginas/home_page/widgets/app_bar_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double widthTela = MediaQuery.of(context).size.width; //tamanho da tela
    double widthStatus = MediaQuery.of(context).padding.top; //tamanho da tela
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            top: -(240 / 4.5),
            left: widthTela - (240 / 1.6),
            child: Opacity(
              child: Image.asset(
                ConstsApp.pokebolaPreta,
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: widthStatus,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('Pokemon'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
