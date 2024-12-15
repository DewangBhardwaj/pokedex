import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokeProvider with ChangeNotifier {
  List<Pokemon> pokeList = [];  // To store the list of Pokémon
  Pokemon? pokemon;  // To store a single Pokémon's data
  bool isLoading = false;  // Flag to indicate loading state
  bool isRequestError = false;  // Flag for error state

  // Method to get home data (list of Pokémon)
  Future<void> getHomeData() async {
    isLoading = true;
    isRequestError = false;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('YOUR_HOME_API_URL'));  // Replace with actual API URL
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        pokeList = (data as List).map((e) => Pokemon.fromJson(e, {})).toList();  // Assuming the response returns a list of Pokémon
      } else {
        isRequestError = true;
      }
    } catch (error) {
      isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Method to get details of a single Pokémon
  Future<void> getPokeData(String pokeId) async {
    isLoading = true;
    isRequestError = false;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('YOUR_POKE_API_URL/$pokeId'));  // Replace with actual API URL for Pokémon details
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final secondResponse = await http.get(Uri.parse('YOUR_SECOND_API_URL/$pokeId'));  // Replace with second API URL for additional data
        final secData = json.decode(secondResponse.body);
        pokemon = Pokemon.fromJson(data, secData);  // Assuming second data is required for the Pokémon
      } else {
        isRequestError = true;
      }
    } catch (error) {
      isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
