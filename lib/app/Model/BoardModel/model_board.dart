import 'package:get/get.dart';

enum Day {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}

class Board {
  final int? id;
  final int? ownerId;
  final String title;
  final String? description;
  final List<Day> cycle; // 요일을 나타내는 리스트
  final String startTime;
  final String endTime;
  final int? authorId;
  final List<Sticker>? stickers; // 스티커 리스트

  Board({
    this.id,
    required this.ownerId,
    required this.title,
    required this.description,
    required this.cycle,
    required this.startTime,
    required this.endTime,
    this.authorId,
    required this.stickers,
  });
}

class BoardVOController extends GetxController {
  final RxList<Board> boardList = <Board>[].obs;

  Future<void> loadBoardData() async {
    try {
      // 보드 데이터를 가져오는 로직 추가
    } catch (e) {
      print("Error fetching board data: $e");
    }
  }
}

class Sticker {
  final int? id;
  final int boardId;
  final String title;
  final String description;
  final int createdAtYear;
  final int createdAtMonth;
  final int createdAtDate;
  final String emojiUnicode;
  final bool isFinished;

  Sticker({
    this.id,
    required this.boardId,
    required this.title,
    required this.description,
    required this.createdAtYear,
    required this.createdAtMonth,
    required this.createdAtDate,
    required this.emojiUnicode,
    required this.isFinished,
  });
}
