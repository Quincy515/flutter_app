import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.lightBlue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _bottomNavigationColor,
          ),
          title: Text('Home', style: TextStyle(color: _bottomNavigationColor)),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.email,
            color: _bottomNavigationColor,
          ),
          title: Text('Email', style: TextStyle(color: _bottomNavigationColor)),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pages,
            color: _bottomNavigationColor,
          ),
          title: Text('Pages', style: TextStyle(color: _bottomNavigationColor)),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.airplay,
            color: _bottomNavigationColor,
          ),
          title:
              Text('Airplay', style: TextStyle(color: _bottomNavigationColor)),
        ),
      ], type: BottomNavigationBarType.fixed),
    );
  }
}
