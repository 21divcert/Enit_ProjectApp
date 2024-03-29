import 'package:enit_project_app/app/Board/view/view_addboarddialog.dart';
import 'package:enit_project_app/app/Board/view/view_boardwidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controller/control_boardpage.dart';

class BoardPage extends StatelessWidget {
  final BoardController boardController = Get.put(BoardController());

  BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/BoardPageBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 50),
            TableCalendarWidget(),
            Text('${boardController.selectedDay} 일의 일정'),
            Expanded(
              child: BoardListWidget(),
            ),
          ],
        ),
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
