import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/pokemon.dart';
import '../helpers/map_cardColor.dart';

class PokeAbout extends StatelessWidget {
  final Pokemon pokeData;
  PokeAbout(this.pokeData);

  String convertValue(value) {
    if (value != null) {
      double convertedValue = value / 10;
      return convertedValue.toStringAsFixed(1); // Limit to one decimal place
    }
    return 'N/A'; // Fallback if value is null
  }

  Widget rowBuilder(String text, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check abilities and provide fallback if they are null
    String abilities = '';
    if (pokeData.ability1.isNotEmpty) {
      abilities += toBeginningOfSentenceCase(pokeData.ability1);
    }
    if (pokeData.ability2.isNotEmpty) {
      abilities += '\n' + toBeginningOfSentenceCase(pokeData.ability2);
    }
    if (pokeData.ability3.isNotEmpty) {
      abilities += '\n' + toBeginningOfSentenceCase(pokeData.ability3);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pokedex Data',
            style: TextStyle(
              color: setTypeColor(pokeData.type1),
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                rowBuilder('Species', pokeData.species),
                rowBuilder('Height', convertValue(pokeData.height) + ' m'),
                rowBuilder('Weight', convertValue(pokeData.weight) + ' kg'),
                rowBuilder('Abilities', abilities),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
