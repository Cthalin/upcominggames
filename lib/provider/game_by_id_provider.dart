import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upcoming_games/models/minimal_game.dart';
import 'package:upcoming_games/provider/wishlist_provider.dart';

import 'games_provider.dart';

final gameByIdProvider = Provider.family<MinimalGame?, int>((ref, id) {
  return ref
      .watch(gamesProvider)
      .games
      .firstWhereOrNull((game) => game.id == id);
});

final gameIsOnWishlistProvider = Provider.family<bool?, int>((ref, id) {
  return ref.watch(wishlistProvider).firstWhereOrNull((game) => game == id) !=
      null;
});
