import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Model/BoardModel/model_board.dart';

class BoardController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;

  late final RxList<Board> boards = <Board>[].obs;

  init() {
    loadBoard();
  }

  void onPageChanged(DateTime day) {
    focusedDay.value = day;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
  }

  void loadBoard() async {
    final boardVOController = Get.put(BoardVOController());
    await boardVOController.loadBoardData();
    boards.value = boardVOController.boardList;
  }

  void removeBoard(int index) {
    //api/delete/boardId
    boards.removeAt(index);
  }
}
