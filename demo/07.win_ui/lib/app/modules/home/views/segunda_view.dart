import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class SegundaView extends GetView<HomeController> {
  const SegundaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('SegundaScreenView')),
      content: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: const [
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextBox(
                  placeholder: 'Typr your notes here',
                ),
              ),
              SizedBox(height: 20),
              ContentD(),
            ],
          )),
    );
  }
}

class ContentD extends StatelessWidget {
  const ContentD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      child: const Text('Content Dialog'),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return ContentDialog(
                title: const Text('Dialog Title'),
                content: const Text('Dialog content'),
                actions: [
                  Button(
                    child: const Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Button(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
