import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/pages/search_page.dart';
import 'package:upcoming_games/theme.dart';
import 'package:upcoming_games/widgets/games_list.dart';
import 'package:upcoming_games/widgets/wishlist.dart';

@RoutePage()
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage() : super(key: null);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late ScrollController _gamesController;
  late ScrollController _wishlistController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _gamesController = ScrollController();
    _wishlistController = ScrollController();
  }

  @override
  void dispose() {
    _gamesController.dispose();
    _wishlistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: Spacing.l),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('Upcoming ', textAlign: TextAlign.end),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Spacing.m,
                  0,
                  Spacing.m,
                  Spacing.s,
                ),
                child: Image.asset(
                  'assets/images/header.png', height: 30,
                  color: Colors.teal,
                  // Tint color
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),
              const Expanded(child: Text(' Games')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: IndexedStack(
            index: selectedIndex,
            children: <Widget>[
              Column(
                children: [
                  GamesList(controller: _gamesController),
                ],
              ),
              const SearchPage(),
              Column(
                children: [
                  Wishlist(controller: _wishlistController),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: (int i) => setState(() {
          selectedIndex = i;
        }),
      ),
    );
  }
}
