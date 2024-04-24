import 'package:enit_project_app/app/Grasspage/controller/control_grasspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class GrassPage extends StatelessWidget {
  GrassPage({Key? key}) : super(key: key);

  final GrassPageController controller = Get.put(GrassPageController());
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
          ],
        ),
      ),
    );
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

  Widget yearMonthCounterSelectMenu() {
    final counter = Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: () {
              final currentDateTime = controller.targetDateTime.value;
              controller.targetDateTime.value = DateTime(currentDateTime.year, currentDateTime.month - 1);
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
