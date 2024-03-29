import 'package:enit_project_app/app/Board/controller/control_boardpage.dart';
import 'package:enit_project_app/app/Board/view/view_addboarddialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/BoardModel/model_board.dart';

class BoardListWidget extends StatelessWidget {
  final BoardController controller = Get.put(BoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold 추가
      body: Obx(() => ListView.builder(
            itemCount: controller.boards.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.boards.length) {
                return _buildAddBoardButton(context);
              }
              final board = controller.boards[index];
              return _buildBoardTile(board); // board 변수 전달
            },
          )),
    );
  }

  Widget _buildAddBoardButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FloatingActionButton(
        onPressed: () => _showAddBoardDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddBoardDialog(BuildContext context) async {
    final boardData = await Get.dialog(AddBoardDialog());
    if (boardData != null) {
      print(boardData);
    }
  }

  Widget _buildBoardTile(Board board) {
    return Transform.translate(
      offset: Offset(0, 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/boardback.jpeg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: Colors.purple[100]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.indigoAccent[100],
              ),
              child: Text(
                board.title, // board의 속성명 변경
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        board.cycle.toString(), // cycle 정보 추가
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        board.startTime,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Text(
                        board.endTime,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 80,
                        child: FloatingActionButton(
                          onPressed: () {
                            // 버튼을 눌렀을 때의 동작 추가
                          },
                          child: Icon(Icons.add),
                          backgroundColor: Colors.indigoAccent[20],
                          elevation: 3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
