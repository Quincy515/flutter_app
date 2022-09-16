import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'HomeView is working',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: () async {
                  await Get.toNamed('/info');
                },
                child: const Text('info'))
          ],
        ),
      ),
    );
  }
}
