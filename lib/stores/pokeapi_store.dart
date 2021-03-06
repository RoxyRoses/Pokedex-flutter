import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi pokeApi;

  @observable
  Pokemon _pokemonAtual;

  @observable
  dynamic corPokemon;

  @observable
  int posicaoAtual;

  @computed
  PokeApi get pokeAPI => pokeApi;

  @computed
  Pokemon get PokemonAtual => _pokemonAtual;

  @action
  pegarListaPokemon() {
    pokeApi = null;
    CarregarPokeApi().then((pokeLista) {
      pokeApi = pokeLista;
    });
  }

  @action
  Pokemon getPokemon({int index}) {
    return pokeApi.pokemon[index];
  }

  @action
  setPokemonAtual({int index}) {
    _pokemonAtual = pokeApi.pokemon[index];
    corPokemon = ConstsApp.getTipoCor(type: _pokemonAtual.type[0]);
    posicaoAtual = index;
  }

  @action
  Widget getImagem({String numero}) {
    return CachedNetworkImage(
      placeholder: (context, url) => new Container(
        color: Colors.transparent,
      ),
      imageUrl:
          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
    );
  }

  Future<PokeApi> CarregarPokeApi() async {
    try {
      final resposta = await http.get(Uri.parse(ConstsAPI.pokeapiURL));
      var decodeJson = jsonDecode(resposta.body);
      return PokeApi.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar Lista" + stacktrace.toString());
      return null;
    }
  }
}

class _pokemon {}
