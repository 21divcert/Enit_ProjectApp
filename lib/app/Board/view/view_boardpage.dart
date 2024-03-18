import 'package:flutter_boardview/board_item.dart';
import 'package:flutter_boardview/board_list.dart';
import 'package:flutter_boardview/boardview.dart';
import 'package:flutter_boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controller/control_board.dart';

class BoardPage extends StatelessWidget {
  final BoardController boardController = Get.put(BoardController());

  BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          TableCalendarWidget(),
          BoardAddButton(),
          Expanded(child: BoardWidget()),
          SizedBox(height: 100),
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

class BoardAddButton extends StatelessWidget {
  final BoardController boardController = Get.find<BoardController>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _showAddBoardDialog(context);
      },
      child: Text('Add Board'),
    );
  }

  Future<void> _showAddBoardDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Board'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  boardController.boardTitle.value = value;
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  boardController.boardDay.value = value;
                },
                decoration: InputDecoration(labelText: 'Day'),
              ),
              TextField(
                onChanged: (value) {
                  boardController.boardStartTime.value = value;
                },
                decoration: InputDecoration(labelText: 'Start Time'),
              ),
              TextField(
                onChanged: (value) {
                  boardController.boardEndTime.value = value;
                },
                decoration: InputDecoration(labelText: 'End Time'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // 입력받은 정보로 보드를 생성
                boardController.createBoardWithInfo(
                  boardController.boardTitle.value,
                  boardController.boardDay.value,
                  boardController.boardStartTime.value,
                  boardController.boardEndTime.value,
                );
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
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
        width: 150,
        boardViewController: boardViewController,
      );
    });
  }

  List<BoardList> _createBoardLists(BoardController controller) {
    return List.generate(controller.boardLists.length, (index) {
      List<String> itemList = controller.boardLists[index].items
              ?.map((e) => e.item.toString())
              .toList() ??
          [];
      List<BoardItem> boardItems = List.generate(
        itemList.length,
        (itemIndex) => BoardItem(item: Text(itemList[itemIndex])),
      );

      boardItems.add(
        BoardItem(
          item: InkWell(
            onTap: () {
              String newItem = "Item ${itemList.length + 1}";
              controller.addItemToBoard(index, newItem);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Icon(Icons.add, size: 24),
            ),
          ),
        ),
      );

      // 사용자로부터 입력받은 값으로 보드 정보 생성
      // String title = controller.boardLists[index].title;
      // String day = controller.boardLists[index].day;
      // String startTime = controller.boardLists[index].startTime;
      // String endTime = controller.boardLists[index].endTime;

      return BoardList();
    });
  }
}
