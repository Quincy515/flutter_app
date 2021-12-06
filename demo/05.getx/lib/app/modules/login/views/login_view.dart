import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              'LoginView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          GetBuilder<LoginController>(
              id: 'userName',
              builder: (login) {
                return Text('当前登录用户是： ${login.name}');
              }),
          ElevatedButton(
            onPressed: () {
              controller.changUser();
            },
            child: Text('click'),
          ),
        ],
      ),
    );
  }
}
