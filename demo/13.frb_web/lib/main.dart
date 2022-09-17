import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/messages.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      translations: Messages(), // 你的翻译
      locale: ui.window.locale,
      fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      debugShowCheckedModeBanner: false,
    ),
  );
}
