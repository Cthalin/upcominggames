import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickerController extends GetxController {
  var _currentDate = new DateTime.now().toString();
  var _currentMonth = new DateTime.now().month;

  getCurrentDate() {
    var date = new DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";

    _currentDate = formattedDate.toString();
    update();
  }

  getLastDayOfMonth() {
    var date = DateTime.parse(_currentDate);
    var lastDay = new DateTime(date.year, date.month + 1, 0);
    var formattedDate = new DateFormat("yyyy-MM-dd").format(lastDay);
    return formattedDate;
  }

  getFirstDayOfMonth() {
    var date = DateTime.parse(_currentDate);
    var formattedDate = new DateFormat("yyyy-MM-01").format(date);
    return formattedDate;
  }

  nextMonth() {
    _currentMonth++;
    // _currentDate =
    //     DateTime.parse(_currentDate).add(new Duration(days: 28)).toString();
    _currentDate = new DateTime(
            DateTime.parse(_currentDate).year,
            DateTime.parse(_currentDate).month + 1,
            1)
        .toString();
    update();
  }

  previousMonth() {
    _currentMonth--;
    // _currentDate = DateTime.parse(_currentDate)
    //     .subtract(new Duration(days: 28))
    //     .toString();
    _currentDate = new DateTime(
        DateTime.parse(_currentDate).year,
        DateTime.parse(_currentDate).month - 1,
        1)
        .toString();
    update();
  }

  String get currentDate => _currentDate.toString();

  String get lastDayOfMonth => getLastDayOfMonth();

  String get firstDayOfMonth => getFirstDayOfMonth();

  String get currentMonth => _currentMonth.toString();
}
