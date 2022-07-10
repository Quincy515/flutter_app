import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const DEFAULT_COUNT_DOWN = Duration.secondsPerMinute * 25;
  int countDown = 0;
  Timer? timer;

  void startCountDown() {
    if (timer != null) timer!.cancel();
    countDown = DEFAULT_COUNT_DOWN;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countDown--;
      });
      debugPrint(countDown.toString());
      if (countDown == 0) {
        timer.cancel();
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("成功获得一个番茄，请注意休息！"),
              );
            });
      }
    });
  }

  String padDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  String parseText() {
    return '${padDigits(countDown ~/ 60)}:${padDigits(countDown % 60)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          parseText(),
          style: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startCountDown,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
