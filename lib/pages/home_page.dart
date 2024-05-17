import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:upcoming_games/provider/date_provider.dart';
import 'package:upcoming_games/theme.dart';
import 'package:upcoming_games/widgets/games_list.dart';

@RoutePage()
class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage() : super(key: null);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
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
                child: Image.asset('assets/images/header.png', height: 30),
              ),
              const Expanded(child: Text(' Games')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GamesList(),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: const Text(
                        "Previous month",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () =>
                          ref.read(dateProvider.notifier).previousMonth(),
                    ),
                  ),
                  Center(
                    child: Text(
                      DateFormat("MMM")
                          .format(
                            DateTime.parse(ref.watch(dateProvider).currentDate),
                          )
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: const Text(
                        "Next month",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () =>
                          ref.read(dateProvider.notifier).nextMonth(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
