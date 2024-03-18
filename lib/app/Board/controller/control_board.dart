import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_boardview/board_item.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_boardview/board_list.dart';

class BoardController extends GetxController {
  final Rx<DateTime> focusedDay = DateTime.now().obs;
  final Rx<CalendarFormat> calendarFormat = CalendarFormat.week.obs;
  final Rx<DateTime> selectedDay = DateTime.now().obs;

  final RxList<BoardList> boardLists = <BoardList>[].obs;

  RxString boardTitle = ''.obs;
  RxString boardDay = ''.obs;
  RxString boardStartTime = ''.obs;
  RxString boardEndTime = ''.obs;

  void onPageChanged(DateTime day) {
    focusedDay.value = day;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  void selectDay(DateTime day) {
    selectedDay.value = day;
  }

  void createBoard() {
    if (boardLists.length < 5) {
      // 새로운 보드를 추가합니다.
      var newBoard = BoardList(
        header: [Text("New Board", style: TextStyle(fontSize: 20))],
        items: [],
        // title: '',
        // day: '',
        // startTime: '',
        // endTime: '',
      );
      boardLists.add(newBoard);
    }
  }

  void addItemToBoard(int boardIndex, String newItem) {
    if (boardIndex < boardLists.length) {
      boardLists[boardIndex].items?.add(newItem as BoardItem);
    }
  }

  void createBoardWithInfo(
      String title, String day, String startTime, String endTime) {
    if (boardLists.length < 5) {
      // 새로운 확장 보드를 추가합니다.
      var newBoard = BoardList(
        // day: day,
        // title: title,
        // startTime: startTime,
        // endTime: endTime,
        items: [BoardItem(item: Text("Initial Item"))], header: [], // 초기 아이템 추가
      );
      boardLists.add(newBoard);
    }
  }

  void whatItem() {}
}
