import 'package:flut/MemoEdit.dart';
import 'package:flut/MemoManager.dart';
import 'package:flut/MemoNew.dart';
import 'package:flut/probiders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key});

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  // final MemoManager memoManager = MemoManager();

  void _deleteMemo(String memoId) {
    final memoIndex =
        memoManager.listMemos().indexWhere((memo) => memo.id == memoId);

    if (memoIndex != -1) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('메모 삭제'),
            content: const Text('메모 삭제를 할까요?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('아니요'),
              ),
              TextButton(
                onPressed: () {
                  memoManager.deleteMemo(memoId); // Memo ID를 사용하여 메모 삭제
                  Navigator.pop(context);
                },
                child: const Text('네'),
              ),
            ],
          );
        },
      );
    } else {
      // 해당 ID의 메모가 없음을 사용자에게 알림
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('메모를 찾을 수 없습니다.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '컬러 메모장',
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MemoNewPage(),
                ));
              },
              icon: const Icon(Icons.add_rounded))
        ],
      ),
      body: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          children: _buildCard(context)),
    );
  }

  List<Widget> _buildCard(BuildContext context) {
    final memoManager = Provider.of<MemoManager>(context);
    final memos = memoManager.listMemos();

    return memos.map((memo) => _buildCardList(context, memo)).toList();
  }

  Widget _buildCardList(BuildContext context, Memo memo) {
    return Card(
      color: memo.color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MemoEditPage(),
                    ));
                  },
                  child: const Icon(Icons.settings),
                ),
                GestureDetector(
                  onTap: () => _deleteMemo(memo.id),
                  child: const Icon(Icons.delete),
                ),
              ],
            ),
            Text(
              memo.title.isEmpty ? '(제목없음)' : memo.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Text(
                memo.body,
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }
}
