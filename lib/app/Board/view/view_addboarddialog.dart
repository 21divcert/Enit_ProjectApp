import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/contorl_addboarddialog.dart';

class AddBoardDialog extends StatelessWidget {
  AddBoardDialog({Key? key}) : super(key: key);

  final AddBoardController controller = Get.put(AddBoardController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('새로운 보드 만들기'),
      content: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTitleField(),
              _buildTimeField(
                label: '시작 시간',
                controller: controller.startTimeController,
              ),
              _buildTimeField(
                label: '종료 시간',
                controller: controller.endTimeController,
              ),
              _buildCycleField(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: controller.boardTitleController,
      decoration: InputDecoration(labelText: '보드 이름'),
      validator: (value) =>
          value == null || value.isEmpty ? '보드 이름을 입력하세요' : null,
    );
  }

  Widget _buildTimeField(
      {required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(label),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(labelText: 'hh:mm'),
              validator: (value) =>
                  value == null || value.isEmpty ? '시간을 입력하세요' : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleField() {
    return Row(
      children: [
        Text('반복할 요일'),
        SizedBox(width: 10),
        Expanded(
          child: Wrap(
            spacing: 8.0,
            children: _buildDayButtons(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDayButtons() {
    final weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return weekdays.map((day) => _buildDayButton(day)).toList();
  }

  Widget _buildDayButton(String day) {
    return Obx(() {
      final bool isSelected = controller.selectedDays.contains(day);
      return ElevatedButton(
        onPressed: () => controller.toggleDay(day),
        style: ButtonStyle(
          backgroundColor:
              isSelected ? MaterialStateProperty.all(Colors.blue) : null,
        ),
        child: Text(
          day,
          style: TextStyle(
            color: isSelected ? Colors.white : null,
          ),
        ),
      );
    });
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('취소'),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: controller.validateAndSubmitForm,
          child: Text('생성'),
        ),
      ],
    );
  }
}
