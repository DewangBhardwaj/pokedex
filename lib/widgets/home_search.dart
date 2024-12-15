import 'package:flutter/material.dart';
import 'package:flutterdex/widgets/search_bar.dart' as custom_search_bar;  // Aliased import

class HomeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),  // Adjusted padding for better spacing
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,  // Aligning content at the top
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Text
          Text(
            'FlutterDex',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 35,
            ),
          ),
          // Description Text
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 45),
            child: Text(
              'Search Pokémon by entering their name or using the Pokédex number.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 20),  // Added space between description and search bar
          // Use the alias 'custom_search_bar' to refer to your custom SearchBar
          custom_search_bar.SearchBar(),
        ],
      ),
    );
  }
}
