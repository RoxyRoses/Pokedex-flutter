// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<PokeApi> _$pokeAPIComputed;

  @override
  PokeApi get pokeAPI =>
      (_$pokeAPIComputed ??= Computed<PokeApi>(() => super.pokeAPI,
              name: '_PokeApiStoreBase.pokeAPI'))
          .value;
  Computed<Pokemon> _$PokemonAtualComputed;

  @override
  Pokemon get PokemonAtual =>
      (_$PokemonAtualComputed ??= Computed<Pokemon>(() => super.PokemonAtual,
              name: '_PokeApiStoreBase.PokemonAtual'))
          .value;

  final _$pokeApiAtom = Atom(name: '_PokeApiStoreBase.pokeApi');

  @override
  PokeApi get pokeApi {
    _$pokeApiAtom.reportRead();
    return super.pokeApi;
  }

  @override
  set pokeApi(PokeApi value) {
    _$pokeApiAtom.reportWrite(value, super.pokeApi, () {
      super.pokeApi = value;
    });
  }

  final _$_pokemonAtualAtom = Atom(name: '_PokeApiStoreBase._pokemonAtual');

  @override
  Pokemon get _pokemonAtual {
    _$_pokemonAtualAtom.reportRead();
    return super._pokemonAtual;
  }

  @override
  set _pokemonAtual(Pokemon value) {
    _$_pokemonAtualAtom.reportWrite(value, super._pokemonAtual, () {
      super._pokemonAtual = value;
    });
  }

  final _$corPokemonAtom = Atom(name: '_PokeApiStoreBase.corPokemon');

  @override
  dynamic get corPokemon {
    _$corPokemonAtom.reportRead();
    return super.corPokemon;
  }

  @override
  set corPokemon(dynamic value) {
    _$corPokemonAtom.reportWrite(value, super.corPokemon, () {
      super.corPokemon = value;
    });
  }

  final _$posicaoAtualAtom = Atom(name: '_PokeApiStoreBase.posicaoAtual');

  @override
  int get posicaoAtual {
    _$posicaoAtualAtom.reportRead();
    return super.posicaoAtual;
  }

  @override
  set posicaoAtual(int value) {
    _$posicaoAtualAtom.reportWrite(value, super.posicaoAtual, () {
      super.posicaoAtual = value;
    });
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  dynamic pegarListaPokemon() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.pegarListaPokemon');
    try {
      return super.pegarListaPokemon();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Pokemon getPokemon({int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getPokemon');
    try {
      return super.getPokemon(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPokemonAtual({int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setPokemonAtual');
    try {
      return super.setPokemonAtual(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImagem({String numero}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getImagem');
    try {
      return super.getImagem(numero: numero);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokeApi: ${pokeApi},
corPokemon: ${corPokemon},
posicaoAtual: ${posicaoAtual},
pokeAPI: ${pokeAPI},
PokemonAtual: ${PokemonAtual}
    ''';
  }
}
