import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class PrimeraView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Primera Screen'),
      ),
      content: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Obx(
              () => Checkbox(
                content: const Text('Check Box'),
                checked: controller.checked.value,
                onChanged: (v) => controller.changeChecked(v),
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => ToggleSwitch(
                content: const Text('Toggle Box'),
                onChanged: (bool value) =>
                    controller.changeToggleSwitchChecked(value),
                checked: controller.toggleSwitchChecked.value,
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => SizedBox(
                width: 200,
                child: Slider(
                  label: '${controller.slider.value.toInt()}',
                  max: 100,
                  onChanged: (double value) => controller.changeSlider(value),
                  value: controller.slider.value,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const ProgressBar(),
            const SizedBox(height: 15),
            const ProgressRing(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
