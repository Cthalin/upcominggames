import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dateProvider = StateNotifierProvider<DateNotifier, DateState>((ref) {
  return DateNotifier();
});

class DateNotifier extends StateNotifier<DateState> {
  DateNotifier()
      : super(
          DateState(
            currentDate: DateTime.now().toString(),
            currentMonth: DateTime.now().month,
          ),
        );

  var _currentDate = DateTime.now().toString();
  var _currentMonth = DateTime.now().month;

  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";

    _currentDate = formattedDate.toString();
    state.currentDate = _currentDate;
  }

  getLastDayOfMonth() {
    var date = DateTime.parse(_currentDate);
    var lastDay = DateTime(date.year, date.month + 1, 0);
    var formattedDate = DateFormat("yyyy-MM-dd").format(lastDay);
    return formattedDate;
  }

  getFirstDayOfMonth() {
    var date = DateTime.parse(_currentDate);
    var formattedDate = DateFormat("yyyy-MM-01").format(date);
    return formattedDate;
  }

  nextMonth() {
    _currentMonth++;
    // _currentDate =
    //     DateTime.parse(_currentDate).add(new Duration(days: 28)).toString();
    _currentDate = DateTime(
      DateTime.parse(_currentDate).year,
      DateTime.parse(_currentDate).month + 1,
      1,
    ).toString();
    state.currentMonth = _currentMonth;
    state.currentDate = _currentDate;
  }

  previousMonth() {
    _currentMonth--;
    // _currentDate = DateTime.parse(_currentDate)
    //     .subtract(new Duration(days: 28))
    //     .toString();
    _currentDate = DateTime(
      DateTime.parse(_currentDate).year,
      DateTime.parse(_currentDate).month - 1,
      1,
    ).toString();
    state.currentMonth = _currentMonth;
    state.currentDate = _currentDate;
  }

  String get currentDate => _currentDate.toString();

  String get lastDayOfMonth => getLastDayOfMonth();

  String get firstDayOfMonth => getFirstDayOfMonth();

  String get currentMonth => _currentMonth.toString();
}

class DateState {
  String currentDate;
  int currentMonth;

  DateState({
    required this.currentDate,
    required this.currentMonth,
  });
}
