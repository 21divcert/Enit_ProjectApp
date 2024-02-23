import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:enit_project_app/app/Board/controller/control_board.dart';

class BoardPage extends StatelessWidget {
  final BoardController boardController = Get.put(BoardController());

  BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30), // 높이가 30인 사이즈 박스
          TableCalendarWidget(),
          Expanded(child: BoardWidget()), // 보드 위젯 추가
        ],
      ),
    );
  }
}

class TableCalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BoardController _controller = Get.find<BoardController>();
    return Obx(() => TableCalendar(
          firstDay: DateTime.utc(2021, 1, 1),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _controller.focusedDay.value,
          calendarFormat: _controller.calendarFormat.value,
          availableCalendarFormats: {
            CalendarFormat.week: 'Week',
            CalendarFormat.month: 'Month',
          },
          onPageChanged: (day) => _controller.onPageChanged(day),
          onFormatChanged: (format) => _controller.onFormatChanged(format),
          selectedDayPredicate: (day) =>
              isSameDay(day, _controller.selectedDay.value),
          onDaySelected: (selectedDay, focusedDay) {
            _controller.selectDay(selectedDay);
            _controller.focusedDay.value = focusedDay;
          },
        ));
  }
}

class BoardWidget extends StatelessWidget {
  final BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    BoardController boardController = Get.find<BoardController>();

    return Obx(() {
      List<BoardList> boardLists = _createBoardLists(boardController);

      return BoardView(
        lists: boardLists,
        boardViewController: boardViewController,
      );
    });
  }

  List<BoardList> _createBoardLists(BoardController controller) {
    List<List<String>> itemLists = [
      controller.dailyItems,
      controller.specialItems,
      controller.importantItems,
      controller.favoriteItems,
      controller.recordItems,
    ];

    List<String> listTitles = [
      "Daily",
      "Special",
      "Important",
      "Favorite",
      "Record"
    ];

    return List.generate(itemLists.length, (index) {
      var itemList = itemLists[index];
      List<BoardItem> boardItems = List.generate(
        itemList.length,
        (itemIndex) => BoardItem(item: Text(itemList[itemIndex])),
      );

      // 각 리스트의 마지막 아이템으로 추가 버튼을 포함시킵니다.
      boardItems.add(
        BoardItem(
          item: InkWell(
            onTap: () {
              // 여기서 아이템 추가 로직을 구현합니다.
              String newItem =
                  "${listTitles[index]} Item ${itemList.length + 1}";
              itemList.add(newItem);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Icon(Icons.add, size: 24),
            ),
          ),
        ),
      );

      return BoardList(
        header: [
          Text("${listTitles[index]} List", style: TextStyle(fontSize: 20)),
        ],
        items: boardItems,
      );
    });
  }
}
