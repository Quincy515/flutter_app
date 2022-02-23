import 'package:fluent_ui/fluent_ui.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class MovelistView extends GetView<HomeController> {
  const MovelistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var res = '';
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('MovieList'),
      ),
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Obx(
          () => Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextBox(
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(FluentIcons.video),
                        ),
                        controller: controller.movieText.value,
                        placeholder: 'Write your movie',
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 200,
                      child: GetBuilder<HomeController>(builder: (controller) {
                        return Combobox(
                          value: controller.comboxBox,
                          onChanged: (value) {
                            if (value != null) {
                              controller.comboxBox = value;
                            }
                          },
                          isExpanded: true,
                          placeholder: const Text('Your movies ...'),
                          items: controller.comboboxList
                              .map(
                                (e) => ComboboxItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Button(
                child: const Text('Add movie'),
                style: ButtonStyle(
                  backgroundColor:
                      ButtonState.resolveWith<Color>((states) => Colors.blue),
                ),
                onPressed: () {
                  res = controller.addMovie();
                  showDialog(
                      context: context,
                      builder: (content) {
                        return ContentDialog(
                          title: Text(res == 'Saved!' ? 'Perfect!' : 'Error'),
                          content: Text(res),
                          actions: [
                            Button(
                              child: const Text('Ok'),
                              style: ButtonStyle(
                                backgroundColor: ButtonState.resolveWith<Color>(
                                    (states) => Colors.blue),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
