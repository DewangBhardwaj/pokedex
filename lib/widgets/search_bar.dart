import 'package:flutter/material.dart';
import 'package:flutterdex/screens/poke_detail_screen.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 20, right: 20),  // Added left and right margin for spacing
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black),
        maxLines: 1,
        controller: _textController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[600]),
          errorText: _validate ? "Please enter a Pokémon name" : null,  // Show error message when validation fails
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          icon: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          hintText: "What Pokémon are you looking for? ",
          suffixIcon: _textController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _textController.clear();
                    setState(() {});
                  },
                )
              : null,  // Show clear button only if there is text
        ),
        onChanged: (value) {
          setState(() {}); // Rebuild the widget when the text changes
        },
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            Navigator.of(context).pushNamed(PokeDetailScreen.routeName, arguments: value);
          } else {
            setState(() {
              _validate = true;  // Set validation to true when the input is empty
            });
          }
        },
      ),
    );
  }
}
