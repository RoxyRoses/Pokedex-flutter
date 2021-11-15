import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:pokedex/models/PokeApiV2.dart';
import 'package:pokedex/models/species.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:pokedex/stores/pokeapiv2_store.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabControlador;
  PageController _controllerPaginas;
  PokeApiStore _pokemonStore;
  PokeApiV2Store _pokeApiV2Store;

  @override
  void initState() {
    super.initState();
    _tabControlador = TabController(length: 3, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
    _controllerPaginas = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Observer(builder: (context) {
            _pokeApiV2Store.getInfoPokemon(_pokemonStore.PokemonAtual.name);
            _pokeApiV2Store.getInfoSpecie(
              _pokemonStore.PokemonAtual.id.toString(),
            );
            return TabBar(
              onTap: (index) {
                _controllerPaginas.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              controller: _tabControlador,
              labelStyle: TextStyle(
                  //up to your taste
                  fontWeight: FontWeight.w700),
              indicatorSize: TabBarIndicatorSize.label, //makes it better
              labelColor: _pokemonStore.corPokemon, //Google's sweet blue
              unselectedLabelColor: Color(0xff5f6368), //niceish grey
              isScrollable: true, //up to your taste
              indicator: MD2Indicator(
                  //it begins here
                  indicatorHeight: 3,
                  indicatorColor: _pokemonStore.corPokemon,
                  indicatorSize: MD2IndicatorSize
                      .normal //3 different modes tiny-normal-full
                  ),
              tabs: <Widget>[
                Tab(
                  text: "Sobre",
                ),
                Tab(
                  text: "Evolução",
                ),
                Tab(
                  text: "Status",
                ),
              ],
            );
          }),
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          _tabControlador.animateTo(
            index,
            duration: Duration(milliseconds: 300),
          );
        },
        controller: _controllerPaginas,
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Descricao',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Observer(builder: (context) {
                    Specie _specie = _pokeApiV2Store.specie;
                    return _specie != null
                        ? Text(
                            _specie.flavorTextEntries
                                .where((descricao) =>
                                    descricao.language.name == 'en')
                                .first
                                .flavorText
                                .replaceAll("\n", " ")
                                .replaceAll("\f", " ")
                                .replaceAll("POKéMON", "Pokémon"),
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          )
                        : SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  _pokemonStore.corPokemon),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
