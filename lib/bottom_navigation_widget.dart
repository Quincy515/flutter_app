import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/airplay_screen.dart';
import 'pages/pages_screen.dart';
import 'pages/email_screen.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.lightBlue;
  int _curentIndex = 0; // 索引
  List<Widget> list = List();

  @override
  void initState() {
    list
      ..add(HomeScreen())
      ..add(EmailScreen())
      ..add(PagesScreen())
      ..add(AirplayScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_curentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _bottomNavigationColor,
            ),
            title:
                Text('Home', style: TextStyle(color: _bottomNavigationColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.email,
              color: _bottomNavigationColor,
            ),
            title:
                Text('Email', style: TextStyle(color: _bottomNavigationColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _bottomNavigationColor,
            ),
            title:
                Text('Pages', style: TextStyle(color: _bottomNavigationColor)),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _bottomNavigationColor,
            ),
            title: Text('Airplay',
                style: TextStyle(color: _bottomNavigationColor)),
          ),
        ],
        currentIndex: _curentIndex,
        onTap: (int index) {
          setState(() {
            _curentIndex = index;
          });
        },
      ),
    );
  }
}
