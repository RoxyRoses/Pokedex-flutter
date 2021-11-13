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
  double _progresso;
  double _multiplo = 1;
  double _opacidade;
  double _tituloOpacidadeAppBar;

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
    _progresso = 0;
    _multiplo = 1;
    _opacidade = 1;
    _tituloOpacidadeAppBar = 0;
  }

//pegar valos slidsheet

  double intervalo(double baixo, double cima, double progresso) {
    assert(baixo < cima);

    if (progresso < cima) return 1.0;
    if (progresso < baixo) return 0.0;

    return ((progresso - baixo) / (cima - baixo)).clamp(0.0, 1.0);
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
                    opacity: _tituloOpacidadeAppBar,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              ControlledAnimation(
                                  playback: Playback.LOOP,
                                  duration: _animacao.duration,
                                  tween: _animacao,
                                  builder: (context, animation) {
                                    return Transform.rotate(
                                      child: AnimatedOpacity(
                                        duration: Duration(microseconds: 200),
                                        child: Image.asset(
                                          ConstsApp.pokebolaBranca,
                                          height: 50,
                                          width: 50,
                                        ),
                                        opacity: _tituloOpacidadeAppBar >= 0.2
                                            ? 0.2
                                            : 0.0,
                                      ),
                                      angle: animation['rotation'],
                                    );
                                  }),
                              IconButton(
                                icon: Icon(Icons.favorite_border),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
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
            listener: (state) {
              setState(() {
                _progresso = state.progress;
                _multiplo = 1 - intervalo(0.60, 0.87, _progresso);
                _opacidade = _multiplo;
                _tituloOpacidadeAppBar =
                    _multiplo = intervalo(0.60, 0.87, _progresso);
              });
            },
            elevation: 0,
            cornerRadius: 30,
            snapSpec: const SnapSpec(
              snap: true,
              snappings: [0.60, 0.87],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                  height: MediaQuery.of(context).size.height //AboutPage(),
                  );
            },
          ),
          Opacity(
            //pokemon desaparecendo
            opacity: _opacidade,
            child: Padding(
              child: SizedBox(
                height: 200,
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      _pokemonLoja.setPokemonAtual(index: index);
                    },
                    itemCount: _pokemonLoja.pokeApi.pokemon.length,
                    itemBuilder: (BuildContext context, int index) {
                      Pokemon _pokeItem = _pokemonLoja.getPokemon(index: index);
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ControlledAnimation(
                              playback: Playback.LOOP,
                              duration: _animacao.duration,
                              tween: _animacao,
                              builder: (context, animation) {
                                return Transform.rotate(
                                  child: AnimatedOpacity(
                                    child: Image.asset(
                                      ConstsApp.pokebolaBranca,
                                      height: 280,
                                      width: 280,
                                    ),
                                    opacity: index == _pokemonLoja.posicaoAtual
                                        ? 0.2
                                        : 0,
                                    duration: Duration(microseconds: 200),
                                  ),
                                  angle: animation['rotation'],
                                );
                              }),
                          IgnorePointer(
                            child: Observer(
                                name: 'Pokemon',
                                builder: (context) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        AnimatedPadding(
                                          child: Hero(
                                            tag: index ==
                                                    _pokemonLoja.posicaoAtual
                                                ? _pokeItem.name
                                                : 'nenhum' + index.toString(),
                                            child: CachedNetworkImage(
                                              height: 160,
                                              width: 160,
                                              placeholder: (context, url) =>
                                                  new Container(
                                                color: Colors.transparent,
                                              ),
                                              color: index ==
                                                      _pokemonLoja.posicaoAtual
                                                  ? null
                                                  : Colors.black
                                                      .withOpacity(0.5),
                                              imageUrl:
                                                  'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokeItem.num}.png',
                                            ),
                                          ),
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.easeIn,
                                          padding: EdgeInsets.only(
                                              top: index ==
                                                      _pokemonLoja.posicaoAtual
                                                  ? 0
                                                  : 60,
                                              bottom: index ==
                                                      _pokemonLoja.posicaoAtual
                                                  ? 0
                                                  : 60),
                                        ),
                                      ]);
                                }),
                          ),
                        ],
                      );
                    }),
              ),
              padding: EdgeInsets.only(
                  top: _tituloOpacidadeAppBar == 1
                      ? 1000
                      : 60 - _progresso * 50),
            ),
          ),
        ],
      ),
    );
  }
}
