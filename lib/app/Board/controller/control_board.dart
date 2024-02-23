import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:table_calendar/table_calendar.dart';

class BoardController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;

  final RxList<String> dailyItems = <String>[].obs;
  final RxList<String> specialItems = <String>[].obs;
  final RxList<String> importantItems = <String>[].obs;
  final RxList<String> favoriteItems = <String>[].obs;
  final RxList<String> recordItems = <String>[].obs;

  void onPageChanged(DateTime day) {
    focusedDay.value = day;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
  }

  void whatItem() {}
}
