import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String nome;
  final int index;
  final Color color;
  final String num;
  final List<String> tipos;

  const PokeItem(
      {Key key, this.nome, this.index, this.color, this.num, this.tipos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: Opacity(
                  child: Image.asset(
                    ConstsApp.pokebolaBranca,
                    height: 90,
                    width: 90,
                  ),
                  opacity: 0.2,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CachedNetworkImage(
                  height: 90,
                  width: 90,
                  placeholder: (context, url) => new Container(
                    color: Colors.transparent,
                  ),
                  imageUrl:
                      'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  nome,
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: ConstsAPI.getTipoCor(type: tipos[0]),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
