import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/paginas/home_page/about_page/about_page.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:pokedex/stores/pokeapiv2_store.dart';
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

  PokeApiStore _pokemonLoja;
  PokeApiV2Store _pokeApiV2Store;
  MultiTrackTween _animacao;
  double _progresso;
  double _multiplo;
  double _opacidade;
  double _tituloOpacidadeAppBar;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.index, viewportFraction: 0.5);
    _pokemonLoja = GetIt.instance<PokeApiStore>();
    _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
    _pokeApiV2Store.getInfoPokemon(_pokemonLoja.PokemonAtual.name);
    _pokeApiV2Store.getInfoSpecie(
      _pokemonLoja.PokemonAtual.id.toString(),
    );
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

    if (progresso > cima) return 1.0;
    if (progresso < baixo) return 0.0;

    return ((progresso - baixo) / (cima - baixo)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Observer(
            builder: (context) {
              return AnimatedContainer(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      _pokemonLoja.corPokemon.withOpacity(0.7),
                      _pokemonLoja.corPokemon,
                    ])),
                child: Stack(
                  children: [
                    AppBar(
                      centerTitle: true,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
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
                                            duration:
                                                Duration(microseconds: 200),
                                            child: Image.asset(
                                              ConstsApp.pokebolaBranca,
                                              height: 50,
                                              width: 50,
                                            ),
                                            opacity:
                                                _tituloOpacidadeAppBar >= 0.2
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
                    ),
                    Positioned(
                      top: (MediaQuery.of(context).size.height * 0.08) -
                          _progresso *
                              (MediaQuery.of(context).size.height * 0.060),
                      left: 20 +
                          _progresso *
                              (MediaQuery.of(context).size.height * 0.060),
                      child: Text(
                        _pokemonLoja.PokemonAtual.name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 35 -
                                _progresso *
                                    (MediaQuery.of(context).size.height *
                                        0.009),
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.10,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setTipos(_pokemonLoja.PokemonAtual.type),
                              Text(
                                '#' + _pokemonLoja.PokemonAtual.num.toString(),
                                style: TextStyle(
                                    fontFamily: 'Google',
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height / 3,
                duration: Duration(milliseconds: 300),
              );
            },
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
              snappings: [0.60, 0.95],
              positioning: SnapPositioning.relativeToAvailableSpace,
            ),
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height * 0.10,
                child: AboutPage(),
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
                      _pokeApiV2Store
                          .getInfoPokemon(_pokemonLoja.PokemonAtual.name);
                      _pokeApiV2Store.getInfoSpecie(
                        _pokemonLoja.PokemonAtual.id.toString(),
                      );
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
                      : (MediaQuery.of(context).size.height * 0.20) -
                          _progresso * 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget setTipos(List<String> tipos) {
    List<Widget> lista = [];
    tipos.forEach((nome) {
      lista.add(
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  nome.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            )
          ],
        ),
      );
    });
    return Row(
      children: lista,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
