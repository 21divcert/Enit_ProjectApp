import 'package:get/get.dart';
import '../../../service/server_service.dart';

enum Day {
  SUN,
  MON,
  TUE,
  WED,
  THU,
  FRI,
  SAT,
}

class Board {
  final int? id;
  final int? ownerId;
  final String title;
  final String? description;
  final List<String> cycle; // 요일을 나타내는 리스트
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

  Map<String, dynamic> toCreateBoardDto() {
    return {
      'createBoardDto': {
        'title': title.toString(),
        'description': description ?? "".toString(),
        'cycle': cycle.map((day) => {'day': day}).toList(),
        'start_time': startTime.toString(),
        'end_time': endTime.toString(),
      },
      'ownerFirebaseAuthUID': "test_value",
    };
  }
}

class Sticker {
  final int? id;
  final int boardId;
  final String emojiUnicode;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final int? authorId;
  final bool isFinished;

  Sticker({
    this.id,
    required this.boardId,
    required this.emojiUnicode,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.authorId,
    required this.isFinished,
  });
}

class BoardVOController extends GetxController {
  final RxList<Board> boardList = <Board>[].obs;

  Future<void> loadBoardData(Map<String, dynamic> requestData) async {
    final formattedRequestData = {
      "ymd": {
        "currentYear": requestData['currentYear'],
        "currentMonth": requestData['currentMonth'],
        "currentDate": requestData['currentDate'],
      },
      "ownerFirebaseAuthUID": "test",
    };

    try {
      ServerAPIService serverAPIService = ServerAPIService();
      serverAPIService.fetchBoardData(formattedRequestData);
      print("model board start!!!!!!!!!!!!!!!!!!");
    } catch (e) {
      print("Error fetching board data: $e");
    }
  }

  Future<void> createBoardData(Map<String, dynamic> formattedBoardData) async {
    try {
      ServerAPIService serverAPIService = ServerAPIService();
      await serverAPIService.createBoardData(formattedBoardData);
      print("model board start!!!!!!!!!!!!!!!!!!");
    } catch (e) {
      print("Error fetching board data: $e");
    }
  }
}
