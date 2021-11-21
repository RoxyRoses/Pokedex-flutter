import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/paginas/home_page/about_page/widgets/aba_evolucao.dart';
import 'package:pokedex/paginas/home_page/about_page/widgets/aba_sobre.dart';
import 'package:pokedex/paginas/home_page/about_page/widgets/aba_status.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabControlador;
  PageController _controllerPaginas;
  PokeApiStore _pokemonStore;
  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _tabControlador = TabController(length: 3, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _controllerPaginas = PageController(initialPage: 0);

    _disposer = reaction(
      (f) => _pokemonStore.PokemonAtual,
      (r) => _controllerPaginas.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
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
          AbaSobre(),
          AbaEvolucao(),
          AbaStatus(),
        ],
      ),
    );
  }
}
