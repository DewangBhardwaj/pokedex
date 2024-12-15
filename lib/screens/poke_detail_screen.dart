import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterdex/provider/poke_provider.dart';
import 'package:flutterdex/widgets/type_card.dart';
import 'package:intl/intl.dart';

class PokeDetailScreen extends StatelessWidget {
  static const routeName = '/poke-detail';

  @override
  Widget build(BuildContext context) {
    final pokeId = ModalRoute.of(context)!.settings.arguments as String;
    final providerData = Provider.of<PokeProvider>(context);
    providerData.getPokeData(pokeId);

    return Scaffold(
      appBar: AppBar(title: Text('PokeDetailScreen')),
      body: providerData.isLoading
          ? Center(child: CircularProgressIndicator())
          : providerData.isRequestError
              ? Center(child: Text('Failed to load data'))
              : providerData.pokemon == null
                  ? Center(child: Text('No Pokémon data'))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(providerData.pokemon!.name),
                          Image.network(providerData.pokemon!.sprite),
                          Text(providerData.pokemon!.description),
                          // Add more details here
                        ],
                      ),
                    ),
    );
  }
}
