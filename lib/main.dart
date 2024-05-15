import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:upcoming_games/date_picker_controller.dart';
import 'package:upcoming_games/games_controller.dart';
import 'package:upcoming_games/image_viewer.dart';

import 'details_page.dart';
import 'games_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.white,
      ),
      home: MyHomePage(
        title: 'Upcoming Games',
        key: UniqueKey(),
      ),
      getPages: [
        GetPage(name: '/details', page: () => DetailsPage()),
        GetPage(name: '/image', page: () => ImageViewer())
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GamesController controller = Get.put(GamesController());
  DatePickerController dateController = Get.put(DatePickerController());

  void _loadGames() {
    controller.loadGames(
        dateController.firstDayOfMonth, dateController.lastDayOfMonth);
  }

  void _loadNextMonth() {
    dateController.nextMonth();
    _loadGames();
  }

  void _loadPreviousMonth() {
    dateController.previousMonth();
    _loadGames();
  }

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
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
                        child: Text("Previous month",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () => _loadPreviousMonth())),
                Center(
                    child: GetBuilder<DatePickerController>(
                        builder: (_) => Text(
                              '${DateFormat("MMM").format(DateTime.parse(_.currentDate)).toUpperCase()}',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ))),
                Expanded(
                    child: TextButton(
                        child: Text("Next month",
                            style: TextStyle(color: Colors.black)),
                        onPressed: () => _loadNextMonth())),
              ],
            )
          ],
        ),
      )),
    );
  }
}
