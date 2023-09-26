import 'package:flut/MemoDto.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MemoNewPage extends StatefulWidget {
  const MemoNewPage({super.key});

  @override
  State<MemoNewPage> createState() => _MemoNewPageState();
}

Color momoColor = Memo.colorDefault;

class _MemoNewPageState extends State<MemoNewPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void _selectColor(Color newColor) {
    setState(() {
      Navigator.pop(context);
      momoColor = newColor;
    });
  }

  void _saveMemo() {
    if (bodyController.text.isNotEmpty) {
      final addedMemo = Memo(
        id: const Uuid().v4(), // 새 메모의 ID 생성, 예: UUID 라이브러리 활용,
        body: bodyController.text,
        title: titleController.text,
        color: momoColor,
      );

      // 새 메모를 MemoListPage로 전달
      Navigator.of(context).pop(addedMemo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('내용을 입력하세요'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _displayColorSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('배경색선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(backgroundColor: Memo.colorDefault),
                title: const Text('흰색'),
                onTap: () => _selectColor(Memo.colorDefault),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Memo.colorRed),
                title: const Text('빨간색'),
                onTap: () => _selectColor(Memo.colorRed),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Memo.colorOrange),
                title: const Text('주황색'),
                onTap: () => _selectColor(Memo.colorOrange),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Memo.colorBlue),
                title: const Text('파란색'),
                onTap: () => _selectColor(Memo.colorBlue),
              ),
              ListTile(
                leading: const CircleAvatar(backgroundColor: Memo.colorGreen),
                title: const Text('초록색'),
                onTap: () => _selectColor(Memo.colorGreen),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 추가'),
        actions: [
          IconButton(
            onPressed: () => _displayColorSelectionDialog(),
            icon: const Icon(Icons.color_lens),
            tooltip: '배경색 선택',
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), label: Text('제목입력')),
              maxLines: 1,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              width: double.infinity,
              height: 200.0, //  수평방향 최대 사이즈,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '메모를 입력해주세요',
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(87, 27, 228, 164),
                    minimumSize: const Size(200, 50)),
                onPressed: () => _saveMemo(),
                child: const Text(
                  '저장하기',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
