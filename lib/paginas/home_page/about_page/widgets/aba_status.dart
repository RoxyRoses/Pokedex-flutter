import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/PokeApiV2.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:pokedex/stores/pokeapiv2_store.dart';

class AbaStatus extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();

  List<int> getStatusPokemon(PokeApiV2 pokeApiV2) {
    List<int> list = [1, 2, 3, 4, 5, 6, 7];
    int sum = 0;
    pokeApiV2.stats.forEach((f) {
      sum = sum + f.baseStat;
      switch (f.stat.name) {
        case 'speed':
          list[0] = f.baseStat;
          break;
        case 'special-defense':
          list[1] = f.baseStat;
          break;
        case 'special-attack':
          list[2] = f.baseStat;
          break;
        case 'defense':
          list[3] = f.baseStat;
          break;
        case 'attack':
          list[4] = f.baseStat;
          break;
        case 'hp':
          list[5] = f.baseStat;
          break;
      }
    });
    list[6] = sum;

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Observer(builder: (context) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Velocidade',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sp. Def',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sp. Atq',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Defesa',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Ataque',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'HP',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Observer(builder: (context) {
                  List<int> _lista =
                      getStatusPokemon(_pokeApiV2Store.pokeApiV2);
                  return Column(
                    children: <Widget>[
                      Text(
                        _lista[0].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _lista[1].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _lista[2].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _lista[3].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _lista[4].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _lista[5].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _lista[6].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 10,
                ),
                Observer(builder: (context) {
                  List<int> _lista =
                      getStatusPokemon(_pokeApiV2Store.pokeApiV2);
                  return Column(
                    children: <Widget>[
                      BarraStatus(
                        widthFactor: _lista[0] / 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BarraStatus(
                        widthFactor: _lista[1] / 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BarraStatus(
                        widthFactor: _lista[2] / 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BarraStatus(
                        widthFactor: _lista[3] / 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BarraStatus(
                        widthFactor: _lista[4] / 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BarraStatus(
                        widthFactor: _lista[5] / 160,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BarraStatus(
                        widthFactor: _lista[6] / 600,
                      ),
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class BarraStatus extends StatelessWidget {
  final double widthFactor;

  const BarraStatus({Key key, this.widthFactor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 19,
      child: Center(
        child: Container(
          height: 4,
          width: MediaQuery.of(context).size.width * .47,
          alignment: Alignment.centerLeft,
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Colors.grey,
          ),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1.0,
            child: Container(
              decoration: ShapeDecoration(
                  shape: StadiumBorder(),
                  color: widthFactor > 0.5 ? Colors.teal : Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
