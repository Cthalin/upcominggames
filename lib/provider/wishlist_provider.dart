import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final wishlistProvider =
    StateNotifierProvider<WishlistProvider, List<int>>((ref) {
  final wishlist = WishlistProvider();
  wishlist.loadWishlist();
  return wishlist;
});

class WishlistProvider extends StateNotifier<List<int>> {
  WishlistProvider() : super([]);

  static const String _wishlistKey = 'wishlist';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loadWishlist() async {
    final SharedPreferences prefs = await _prefs;
    List<String>? wishlistStr = prefs.getStringList(_wishlistKey);
    if (wishlistStr != null) {
      state = wishlistStr.map((item) => int.parse(item)).toList();
    } else {
      state = [];
    }
  }

  Future<void> addToWishlist(int gameId) async {
    final SharedPreferences prefs = await _prefs;
    if (!state.contains(gameId)) {
      state = [...state, gameId];
      await prefs.setStringList(
        _wishlistKey,
        state.map((item) => item.toString()).toList(),
      );
    }
  }

  Future<void> removeFromWishlist(int gameId) async {
    final SharedPreferences prefs = await _prefs;
    if (state.contains(gameId)) {
      state = state.where((id) => id != gameId).toList();
      await prefs.setStringList(
        _wishlistKey,
        state.map((item) => item.toString()).toList(),
      );
    }
  }

  bool isGameInWishlist(int gameId) {
    return state.contains(gameId);
  }
}
