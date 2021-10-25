import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/paginas/home_page/widgets/app_bar_home.dart';
import 'package:pokedex/paginas/home_page/widgets/poke_item.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;
  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.pegarListaPokemon();
  }

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
                    child: Observer(
                      name: 'Lista Home pAGE',
                      builder: (BuildContext context) {
                        PokeApi _pokeApi = pokeApiStore.pokeApi;
                        return (_pokeApi != null)
                            ? AnimationLimiter(
                                child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(12),
                                addAutomaticKeepAlives: true,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: pokeApiStore.pokeAPI.pokemon.length,
                                itemBuilder: (context, index) {
                                  Pokemon pokemon =
                                      pokeApiStore.getPokemon(index: index);
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 2,
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: PokeItem(
                                            tipos: pokemon.type,
                                            index: index,
                                            nome: pokemon.name,
                                            num: pokemon.num,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Container(),
                                                fullscreenDialog: true,
                                              ));
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ))
                            : Center(
                                child: CircularProgressIndicator(),
                              );
                      },
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
