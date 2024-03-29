import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

import './primera_view.dart';
import './segunda_view.dart';
import '../controllers/home_controller.dart';
import './movelist_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluent UI',
      theme: ThemeData.dark(),
      home: Obx(
        () => NavigationView(
          appBar: const NavigationAppBar(
            leading: Center(
              child: FlutterLogo(size: 25),
            ),
          ),
          pane: NavigationPane(
            header: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: DefaultTextStyle(
                style: TextStyle(),
                child: Text('Fluent UI'),
              ),
            ),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.a_t_p_logo),
                title: const Text('Sceen 1'),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.text_box),
                title: const Text('Sceen 2'),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.my_movies_t_v),
                title: const Text('Movie List'),
              ),
            ],
            selected: controller.currentIndex.value,
            displayMode: PaneDisplayMode.auto,
            onChanged: (i) => controller.changeCurrentIndex(i),
          ),
          content: NavigationBody(
            index: controller.currentIndex.value,
            children: const [
              PrimeraView(),
              SegundaView(),
              MovelistView(),
            ],
          ),
        ),
      ),
    );
  }
}
