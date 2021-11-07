import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokePaginaDetalhes extends StatefulWidget {
  final int index;

  PokePaginaDetalhes({Key key, this.index}) : super(key: key);

  @override
  State<PokePaginaDetalhes> createState() => _PokePaginaDetalhesState();
}

class _PokePaginaDetalhesState extends State<PokePaginaDetalhes> {
  PageController _pageController;
  Pokemon _pokemon;
  PokeApiStore _pokemonLoja;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonLoja = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonLoja.PokemonAtual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Observer(
          builder: (context) {
            return Observer(
              builder: (BuildContext context) {
                return AppBar(
                  title: Opacity(
                    child: Text(
                      _pokemon.name,
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    ),
                    opacity: 0.0,
                  ),
                  elevation: 0,
                  backgroundColor: _pokemonLoja.corPokemon,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return Container(color: _pokemonLoja.corPokemon);
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SlidingSheet(
            elevation: 8,
            cornerRadius: 16,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.7, 1.0],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
              );
            },
          ),
          Padding(
            child: SizedBox(
              height: 190,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokemonLoja.setPokemonAtual(index: index);
                  },
                  itemCount: _pokemonLoja.pokeApi.pokemon.length,
                  itemBuilder: (BuildContext context, int count) {
                    Pokemon _pokeItem = _pokemonLoja.getPokemon(index: count);
                    return CachedNetworkImage(
                      height: 60,
                      width: 60,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl:
                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                    );
                  }),
            ),
            padding: EdgeInsets.only(top: 50),
          ),
        ],
      ),
    );
  }
}
