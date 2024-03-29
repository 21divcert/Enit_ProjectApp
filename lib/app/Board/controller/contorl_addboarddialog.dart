import 'package:enit_project_app/app/Board/controller/control_boardpage.dart';
import 'package:enit_project_app/app/Model/BoardModel/model_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBoardController extends GetxController {
  final TextEditingController _boardTitleController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final RxString _selectedCycle = 'Sunday'.obs;
  final RxList<String> selectedDays = <String>[].obs;

  TextEditingController get boardTitleController => _boardTitleController;
  TextEditingController get startTimeController => _startTimeController;
  TextEditingController get endTimeController => _endTimeController;
  RxString get selectedCycle => _selectedCycle;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validateAndSubmitForm() {
    if (formKey.currentState!.validate()) {
      final boardData = {
        'title': _boardTitleController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
        'cycle': _selectedCycle.value,
      };
      Get.back(result: boardData);

      saveBoardData();
    }
  }

  void saveBoardData() async {
    final BoardVOController controller = Get.put(BoardVOController());
    final BoardController boardController = Get.put(BoardController());

    final Day selectedDay = _stringToDay(_selectedCycle.value);

    final newBoard = Board(
      id: null,
      ownerId: null,
      title: _boardTitleController.text,
      description: null,
      cycle: [selectedDay],
      startTime: _startTimeController.text,
      endTime: _endTimeController.text,
      authorId: null,
      stickers: null,
    );

    controller.boardList.add(newBoard);

    boardController.loadBoard();

    // api 보드 데이터 저장
  }

  Day _stringToDay(String value) {
    switch (value) {
      case 'Sunday':
        return Day.Sunday;
      case 'Monday':
        return Day.Monday;
      case 'Tuesday':
        return Day.Tuesday;
      case 'Wednesday':
        return Day.Wednesday;
      case 'Thursday':
        return Day.Thursday;
      case 'Friday':
        return Day.Friday;
      case 'Saturday':
        return Day.Saturday;
      case '일':
        return Day.Sunday;
      case '월':
        return Day.Monday;
      case '화':
        return Day.Tuesday;
      case '수':
        return Day.Wednesday;
      case '목':
        return Day.Thursday;
      case '금':
        return Day.Friday;
      case '토':
        return Day.Saturday;
      default:
        throw ArgumentError('Invalid day: $value');
    }
  }

  void toggleDay(String day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day); // 이미 선택된 요일이면 선택 취소
    } else {
      selectedDays.add(day); // 선택되지 않은 요일이면 선택 추가
    }
    update(); // 해당 위젯을 다시 빌드하여 변경 사항을 반영
  }
}
