import 'package:flut/MemoEdit.dart';
import 'package:flut/MemoList.dart';
import 'package:flut/MemoManager.dart';
import 'package:flut/MemoNew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MemoManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          "/list": (context) => const MemoListPage(),
          "/new": (context) => const MemoNewPage(),
          "/edit": (context) => const MemoEditPage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 234, 251, 53)),
          useMaterial3: true,
        ),
        home: const MemoListPage());
  }
}
