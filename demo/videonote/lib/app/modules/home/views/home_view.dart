import 'package:get/get.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FluentTheme(
      data: ThemeData(),
      child: Center(
          child: Button(
        onPressed: () async {
          await Get.toNamed('/info');
        },
        child: const Text('info'),
      )),
    );
  }
}
