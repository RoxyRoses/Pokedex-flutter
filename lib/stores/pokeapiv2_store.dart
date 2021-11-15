import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/PokeApiV2.dart';
import 'package:pokedex/models/species.dart';
import 'package:http/http.dart' as http;
part 'pokeapiv2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  @observable
  Specie specie;

  @observable
  PokeApiV2 pokeApiV2;

  @action
  Future<void> getInfoPokemon(String nome) async {
    try {
      final resposta = await http.get(
        Uri.parse(ConstsAPI.pokeapiv2URL + nome.toLowerCase()),
      );
      var decodeJson = jsonDecode(resposta.body);
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar Lista" + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecie(String numPokemon) async {
    try {
      final resposta = await http
          .get(Uri.parse(ConstsAPI.pokeapiv2EspeciesURL + numPokemon));
      var decodeJson = jsonDecode(resposta.body);
      specie = Specie.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar Lista" + stacktrace.toString());
      return null;
    }
  }
}
