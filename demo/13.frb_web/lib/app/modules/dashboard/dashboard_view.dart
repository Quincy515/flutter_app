import 'package:fluent_ui/fluent_ui.dart';

import 'package:get/get.dart';

import '../note/note_view.dart';
import 'dashboard_controller.dart';

const String appTitle = 'Fluent UI Showcase for Flutter';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);
  final viewKey = GlobalKey();
  final List<NavigationPaneItem> originalItems = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: Text('Home'.tr),
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      items: [
        PaneItem(
          icon: const Icon(FluentIcons.home),
          title: Text('Inputs'.tr),
        ),
      ],
    ),
  ];
  late List<NavigationPaneItem> items = originalItems;

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      locale: Get.locale!,
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: NavigationView(
        key: viewKey,
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: () {
            return const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            );
          }(),
        ),
        pane: NavigationPane(
          selected: controller.index.value,
          onChanged: (i) => controller.setIndex(i),
          displayMode: PaneDisplayMode.auto,
          items: items,
        ),
        content: NavigationBody.builder(
          index: controller.index.value,
          itemBuilder: (context, index) {
            return const ScaffoldPage(
              content: NoteView(),
            );
          },
        ),
      ),
    );
  }
}
