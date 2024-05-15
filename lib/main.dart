import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_router.dart';

void main() {
  runApp(
    ProviderScope(
      child: UpcomingGamesApp(),
    ),
  );
}

class UpcomingGamesApp extends StatelessWidget {
  UpcomingGamesApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.white,
      ),
    );
  }
}
