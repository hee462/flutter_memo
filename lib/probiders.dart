import 'package:flut/MemoManager.dart';

// momoMenager 를 사요해서 어디든 사용가능하게
MemoManager? _memoManager;

MemoManager get memoManager {
  _memoManager ??= MemoManager();
  return _memoManager!;
}
