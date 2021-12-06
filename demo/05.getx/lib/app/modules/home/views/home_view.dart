import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              controller.count.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
              child: Text('Increment')),
        ],
      ),
    );
  }
}
