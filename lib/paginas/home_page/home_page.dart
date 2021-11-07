import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/paginas/home_page/poke_details/poke_detalhes.dart';
import 'package:pokedex/paginas/home_page/widgets/app_bar_home.dart';
import 'package:pokedex/paginas/home_page/widgets/poke_item.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();
    _pokemonStore = GetIt.instance<PokeApiStore>();
    if (_pokemonStore.pokeApi == null) {
      _pokemonStore.pegarListaPokemon();
    }
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
                        PokeApi _pokeApi = _pokemonStore.pokeApi;
                        return (_pokeApi != null)
                            ? AnimationLimiter(
                                child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.all(12),
                                addAutomaticKeepAlives: true,
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemCount: _pokemonStore.pokeAPI.pokemon.length,
                                itemBuilder: (context, index) {
                                  Pokemon pokemon =
                                      _pokemonStore.getPokemon(index: index);
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
                                          _pokemonStore.setPokemonAtual(
                                              index: index);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PokePaginaDetalhes(
                                                            index: index),
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
