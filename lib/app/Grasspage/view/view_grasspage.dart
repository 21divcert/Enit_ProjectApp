import 'dart:developer';

import 'package:enit_project_app/app/Grasspage/controller/control_grasspage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GrassPage extends StatelessWidget {
  GrassPage({Key? key}) : super(key: key);

  final GrassPageController controller = Get.put(GrassPageController());
  @override
  Widget build(BuildContext context) {
    final finishedScaffold = Scaffold(
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
            GrasserWidget(),
          ],
        ),
      ),
    );

    return finishedScaffold;
  }
}

class TableCalendarWidget extends StatelessWidget {
  final GrassPageController controller = Get.put(GrassPageController());
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 30),
        Obx(() => controller.isWeekGrasser.value ? yearCounterSelectMenu() : yearMonthCounterSelectMenu()),
        SizedBox(width: 30),
      ],
    );
  }

  void refreshIntenseData() {
    controller.grassRefreshData();
  }

  Widget yearMonthCounterSelectMenu() {
    final counter = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              final currentDateTime = controller.targetDateTime.value;
              controller.targetDateTime.value = DateTime(currentDateTime.year, currentDateTime.month - 1);
              refreshIntenseData();
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Obx(() => Text(
                    '${controller.targetDateTime.value.year} .${controller.targetDateTime.value.month}',
                    style: TextStyle(fontSize: 26),
                  )),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          dayWeekToggleButton(),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              final currentDateTime = controller.targetDateTime.value;
              controller.targetDateTime.value = DateTime(currentDateTime.year, currentDateTime.month + 1);
              refreshIntenseData();
            },
            icon: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
    return counter;
  }

  Widget yearCounterSelectMenu() {
    final counter = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              final currentDateTime = controller.targetDateTime.value;
              controller.targetDateTime.value = DateTime(currentDateTime.year - 1, currentDateTime.month);
              refreshIntenseData();
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Obx(() => Text(
                    '${controller.targetDateTime.value.year}',
                    style: TextStyle(fontSize: 26),
                  )),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          dayWeekToggleButton(),
          SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () {
              final currentDateTime = controller.targetDateTime.value;
              controller.targetDateTime.value = DateTime(currentDateTime.year + 1, currentDateTime.month);
              refreshIntenseData();
            },
            icon: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
    return counter;
  }

  Widget dayWeekToggleButton() {
    final widget = OutlinedButton(
      child: Obx(() => (Text("${controller.isWeekGrasser.value ? 'week' : 'day'}", style: TextStyle(fontSize: 16)))),
      onPressed: toggleAction,
      style: ButtonStyle(),
    );
    return SizedBox(
      child: widget,
      width: 100,
    );
  }

  void toggleAction() {
    if (controller.isWeekGrasser.value == true) {
      controller.isWeekGrasser.value = false;
    } else {
      controller.isWeekGrasser.value = true;
    }
  }
}

class GrasserWidget extends StatelessWidget {
  final GrassPageController controller = Get.put(GrassPageController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.refreshStatue,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            EasyLoading.dismiss();
            return Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: modeGrasserSelect(
                      controller.grasserIntenseList, controller.isWeekGrasser.value, controller.targetDateTime.value),
                ),
              ),
            );
          } else {
            EasyLoading.show();
            return Center();
          }
        }));
  }

  List<Widget> modeGrasserSelect(List<List<int>> intenseData, bool isWeekGrasser, DateTime userSelectedDate) {
    final List<Widget> resultWidgetList = [];
    final List<String> widgetLabelList = [];
    if (isWeekGrasser) {
      // fill the resultWidgetList
      for (int index = 0; index < controller.indexRange * 2 + 1; index++) {
        resultWidgetList.add(grasserWeekUnit(intenseData[index], controller.targetBoardIdList.length));
      }

      // fill the LabelList
      for (int monthOffset = -controller.indexRange; monthOffset <= controller.indexRange; monthOffset++) {
        final targetDateTime = DateTime(userSelectedDate.year, userSelectedDate.month + monthOffset, 1);
        widgetLabelList.add("${targetDateTime.year}");
      }
    } else {
      // calculate the day offset.
      final List<int> offsetList = [];
      for (int monthOffset = -controller.indexRange; monthOffset <= controller.indexRange; monthOffset++) {
        final targetDateTime = DateTime(userSelectedDate.year, userSelectedDate.month + monthOffset, 1);
        final offset = targetDateTime.weekday; //  offset 1 means that month starts with monday.
        offsetList.add(offset);
      }

      // fill the resultWidgetList
      for (int index = 0; index < controller.indexRange * 2 + 1; index++) {
        resultWidgetList.add(grasserDayUnit(intenseData[index], controller.targetBoardIdList.length, offsetList[index]));
      }

      // fill the LabelList
      for (int monthOffset = -controller.indexRange; monthOffset <= controller.indexRange; monthOffset++) {
        final targetDateTime = DateTime(userSelectedDate.year, userSelectedDate.month + monthOffset, 1);
        widgetLabelList.add("${targetDateTime.year} .${targetDateTime.month}");
      }
    }

    return List.generate(
        resultWidgetList.length,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey.withOpacity(0.3),
              ),
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(5),
                      child: Text(
                        "${widgetLabelList[index]}",
                        style: TextStyle(fontSize: 16),
                      )),
                  resultWidgetList[index],
                ],
              ),
            ));
  }

  Widget grasserDayUnit(List<int> unitIntenseList, int totalBoardCount, int startOffset) {
    final List<Widget> intensedDayUnitList = [];

    // make the colored cell
    for (int intense in unitIntenseList) {
      final colorRatio = intense / totalBoardCount;
      final dayUnit = Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Color.lerp(Colors.black12, Colors.green.shade700, colorRatio), borderRadius: BorderRadius.circular(10)),
      );

      intensedDayUnitList.add(dayUnit);
    }

    // make the empty cell to the start
    for (int i = 0; i < startOffset; i++) {
      final dayUnit = Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: const Color.fromARGB(0, 0, 0, 0)),
      );

      intensedDayUnitList.insert(0, dayUnit);
    }

    // make the empty cell to the end
    var endOffset = 7 - intensedDayUnitList.length % 7;
    if (endOffset == 7) {
      endOffset = 0;
    }
    for (int i = 0; i < endOffset; i++) {
      final dayUnit = Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(color: const Color.fromARGB(0, 0, 0, 0)),
      );

      intensedDayUnitList.add(dayUnit);
    }
    final List<Widget> rowList = [];

    while (intensedDayUnitList.length > 0) {
      final List<Widget> rowChildren = [];
      for (int i = 0; i < 7; i++) {
        final removedWidget = intensedDayUnitList.removeAt(0);
        final addedWidget = Expanded(child: removedWidget);
        rowChildren.add(addedWidget);
      }
      final row = Expanded(
        child: Row(
          children: rowChildren,
        ),
      );
      rowList.add(row);
    }

    final motherContainer = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      width: Get.width * 0.8,
      height: Get.width * 0.1 * rowList.length,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Column(
        children: rowList,
      ),
    );

    return motherContainer;
  }

  Widget grasserWeekUnit(List<int> unitIntenseList, int totalBoardCount) {
    final List<Widget> intensedDayUnitList = [];

    // make the colored cell
    for (int intense in unitIntenseList) {
      final colorRatio = intense / totalBoardCount;
      final dayUnit = Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Color.lerp(Colors.black12, Colors.green.shade700, colorRatio), borderRadius: BorderRadius.circular(10)),
      );

      intensedDayUnitList.add(dayUnit);
    }

    final List<Widget> rowList = [];

    while (intensedDayUnitList.length > 0) {
      final List<Widget> rowChildren = [];
      for (int i = 0; i < 4; i++) {
        final removedWidget = intensedDayUnitList.removeAt(0);
        final addedWidget = Expanded(child: removedWidget);
        rowChildren.add(addedWidget);
      }
      final row = Expanded(
        child: Row(
          children: rowChildren,
        ),
      );
      rowList.add(row);
    }

    final motherContainer = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(0, 0, 0, 0),
      ),
      width: Get.width * 0.8,
      height: Get.width * 0.6,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      child: Column(
        children: rowList,
      ),
    );

    return motherContainer;
  }
}
