import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterdex/provider/poke_provider.dart';
import 'package:flutterdex/widgets/poke_card.dart';
import '../widgets/home_search.dart';  // Import the HomeSearch widget

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load home data when the screen is initialized
    Provider.of<PokeProvider>(context, listen: false).getHomeData();
  }

  Future<void> _refreshData(BuildContext context) async {
    await Provider.of<PokeProvider>(context, listen: false).getHomeData();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PokeProvider>(context);
    final pokeData = data.pokeList;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
        child: Column(
          children: [
            // This is where HomeSearch is used
            Container(
              padding: EdgeInsets.only(bottom: 15),
              height: MediaQuery.of(context).size.width / 1.5,
              width: MediaQuery.of(context).size.width,
              child: HomeSearch(),  // Here we use HomeSearch
            ),
            Expanded(
              child: data.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      onRefresh: () => _refreshData(context),
                      child: ListView.builder(
                        itemCount: pokeData.length,
                        itemBuilder: (ctx, index) {
                          return PokeCard(pokeData[index], context);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
