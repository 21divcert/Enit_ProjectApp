import 'package:enit_project_app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Model/BoardModel/model_board.dart';

class BoardController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;

  late final RxList<Board> boards = <Board>[].obs;

  final boardVOController = Get.put(BoardVOController());

  late PageController _pageController;

  @override
  void onInit() {
    _pageController = PageController();

    if (boardVOController.ownerFirebaseAuthUID.value == null) {
      boardVOController.injectOwnerFirebaseAuthUID(AuthService.to.getCurrentUser()?.uid);
    }
    super.onInit();
  }

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
    loadBoard();
  }

  void loadBoard() async {
    final requestData = {
      'currentYear': selectedDay.value.year,
      'currentMonth': selectedDay.value.month,
      'currentDate': selectedDay.value.day,
    };

    try {
      print("load start!!!!!!!!!!!!!!!!!!");
      await boardVOController.loadBoardData(requestData);
      boards.value = boardVOController.boardList;
    } catch (e) {
      print("Error fetching board data: $e");
    }
  }

  void removeBoard(int index) {
    //api/delete/boardId
    boards.removeAt(index);
  }
}
