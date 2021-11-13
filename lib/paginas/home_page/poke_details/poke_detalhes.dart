import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/paginas/home_page/widgets/poke_item.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:simple_animations/simple_animations.dart';
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
  MultiTrackTween _animacao;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonLoja = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonLoja.PokemonAtual;
    _animacao = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
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
            cornerRadius: 30,
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
              height: 200,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    _pokemonLoja.setPokemonAtual(index: index);
                  },
                  itemCount: _pokemonLoja.pokeApi.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    Pokemon _pokeItem = _pokemonLoja.getPokemon(index: index);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ControlledAnimation(
                            playback: Playback.LOOP,
                            duration: _animacao.duration,
                            tween: _animacao,
                            builder: (context, animation) {
                              return Transform.rotate(
                                child: Hero(
                                  tag: index.toString(),
                                  child: Opacity(
                                    child: Image.asset(
                                      ConstsApp.pokebolaBranca,
                                      height: 280,
                                      width: 280,
                                    ),
                                    opacity: 0.2,
                                  ),
                                ),
                                angle: animation['rotation'],
                              );
                            }),
                        Observer(builder: (context) {
                          return AnimatedPadding(
                            duration: Duration(milliseconds: 400),
                            curve: Curves.bounceInOut,
                            padding: EdgeInsets.all(
                                index == _pokemonLoja.posicaoAtual ? 0 : 60),
                            child: CachedNetworkImage(
                              height: 180,
                              width: 180,
                              placeholder: (context, url) => new Container(
                                color: Colors.transparent,
                              ),
                              color: index == _pokemonLoja.posicaoAtual
                                  ? null
                                  : Colors.black.withOpacity(0.5),
                              imageUrl:
                                  'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                            ),
                          );
                        }),
                      ],
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
