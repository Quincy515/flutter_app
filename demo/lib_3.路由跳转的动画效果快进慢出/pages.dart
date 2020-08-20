import 'package:flutter/material.dart';
import 'custom_router.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          'FirstPage',
          style: TextStyle(fontSize: 36.0),
        ),
        elevation: 0.0, // 与底部融合
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
            size: 64.0,
          ),
          onPressed: () {
            Navigator.of(context)
                // .push(MaterialPageRoute(builder: (BuildContext context) {return SecondPage();}));
                .push(CustomRoute(SecondPage()));
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'SecondPage',
          style: TextStyle(fontSize: 36.0),
        ),
        leading: Container(), // 放置在中间
        elevation: 4.0, // 与底部融合
      ),
      body: Center(
        child: MaterialButton(
          child: Icon(
            Icons.navigate_before,
            color: Colors.white,
            size: 64.0,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
