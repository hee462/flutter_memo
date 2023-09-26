import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Memo {
  static const colorDefault = Colors.white;
  static const colorRed = Color.fromARGB(255, 248, 116, 142);
  static const colorBlue = Color.fromARGB(255, 117, 134, 246);
  static const colorGreen = Color.fromARGB(255, 144, 248, 146);
  static const colorOrange = Color.fromARGB(255, 246, 186, 113);

  final String id;
  final String title;
  final String body;
  final Color color;

  Memo({
    String? id, // 생성자에 ID 파라미터 추가
    required this.title,
    required this.body,
    required this.color,
  }) : id = id ?? const Uuid().v4(); // ID가 주어지지 않으면 UUID로 생성
}
