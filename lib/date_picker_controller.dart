import 'package:intl/intl.dart';

class DatePickerController {
  var _currentDate = DateTime.now().toString();
  var _currentMonth = DateTime.now().month;

  getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";

    _currentDate = formattedDate.toString();
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
  }

  String get currentDate => _currentDate.toString();

  String get lastDayOfMonth => getLastDayOfMonth();

  String get firstDayOfMonth => getFirstDayOfMonth();

  String get currentMonth => _currentMonth.toString();
}
