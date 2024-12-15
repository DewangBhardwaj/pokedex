import 'dart:convert';

class Pokemon {
  String id;
  String name;
  String sprite;
  String type1;
  String? type2;
  double hp;
  double attack;
  double defense;
  double speed;
  double spAttack;
  double spDefense;
  String description;
  double height;
  double weight;
  String species;
  String ability1;
  String ability2;
  String ability3;
  List<String> moves;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprite,
    required this.type1,
    this.type2,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.spAttack,
    required this.spDefense,
    required this.description,
    required this.height,
    required this.weight,
    required this.species,
    required this.ability1,
    required this.ability2,
    required this.ability3,
    required this.moves,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json, Map<String, dynamic> secJson) {
    // Parse stats
    int hp = json['stats'][0]['base_stat'];
    int attack = json['stats'][1]['base_stat'];
    int defense = json['stats'][2]['base_stat'];
    int spAttack = json['stats'][3]['base_stat'];
    int spDefense = json['stats'][4]['base_stat'];
    int speed = json['stats'][5]['base_stat'];

    // Get description
    List descList = secJson['flavor_text_entries'];
    int descIndex = 0;
    for (int i = 0; i < descList.length; i++) {
      var desc = secJson['flavor_text_entries'][i]['language']['name'];
      if (desc == 'en') {
        descIndex = i;
        break;
      }
    }
    String pokeDesc = secJson['flavor_text_entries'][descIndex]['flavor_text'];
    String pokeSpec = secJson['genera'].firstWhere(
      (genus) => genus['language']['name'] == 'en',
      orElse: () => {'genus': 'Unknown'},
    )['genus'];

    // Calculate stats as percentages
    double pokeHp = hp / 100;
    double pokeAttack = attack / 100;
    double pokeDef = defense / 100;
    double pokeSpAttack = spAttack / 100;
    double pokespDefense = spDefense / 100;
    double pokeSpeed = speed / 100;

    // Collect abilities and moves
    List abilities = json['abilities'];
    List<String> tempMovesList = [];
    List movesList = json['moves'] ?? [];
    for (int i = 0; i < movesList.length; i++) {
      var move = movesList[i]['move']['name'];
      tempMovesList.add(move);
    }

    return Pokemon(
      id: json['id'].toString(),
      name: json['name'],
      sprite: json['sprites']['front_default'],
      type1: json['types'][0]['type']['name'],
      type2: json['types'].length > 1 ? json['types'][1]['type']['name'] : null,
      hp: pokeHp,
      attack: pokeAttack,
      defense: pokeDef,
      speed: pokeSpeed,
      spAttack: pokeSpAttack,
      spDefense: pokespDefense,
      description: pokeDesc,
      height: json['height'].toDouble(),
      weight: json['weight'].toDouble(),
      species: pokeSpec,
      ability1: abilities.isNotEmpty ? abilities[0]['ability']['name'] : '',
      ability2: abilities.length >= 2 ? abilities[1]['ability']['name'] : '',
      ability3: abilities.length >= 3 ? abilities[2]['ability']['name'] : '',
      moves: tempMovesList,
    );
  }
}
