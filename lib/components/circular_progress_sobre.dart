import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/stores/pokeapi_store.dart';

class CircularProgressSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SizedBox(
          height: 15,
          width: 15,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                GetIt.instance<PokeApiStore>().corPokemon),
          ),
        ),
      ),
    );
  }
}
