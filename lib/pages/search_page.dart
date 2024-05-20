import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:upcoming_games/provider/search_provider.dart';
import 'package:upcoming_games/widgets/game_card.dart';

import '../theme.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search games...',
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                ref
                    .read(searchProvider.notifier)
                    .search(_searchController.text);
              },
            ),
          ),
          onSubmitted: (query) {
            ref.read(searchProvider.notifier).search(query);
          },
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final searchResults = ref.watch(searchProvider).games;
          final isLoading = ref.watch(searchProvider).isLoading;
          return isLoading
              ? Center(
                  child: Lottie.asset('assets/animations/loading.json'),
                )
              : ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(Spacing.xl),
                      child: GameCard(searchResults[index]),
                    );
                  },
                );
        },
      ),
    );
  }
}
