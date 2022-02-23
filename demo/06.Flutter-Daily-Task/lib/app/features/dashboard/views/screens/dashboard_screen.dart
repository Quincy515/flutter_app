library dashboard;

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/constans/app_constants.dart';
import 'package:template/app/shared_components/card_task.dart';
import 'package:template/app/shared_components/header_text.dart';
import 'package:template/app/shared_components/search_field.dart';
import 'package:template/app/shared_components/selection_button.dart';
import 'package:template/app/shared_components/simple_selection_button.dart';
import 'package:template/app/shared_components/simple_user_profile.dart';
import 'package:template/app/shared_components/task_progress.dart';
import 'package:template/app/shared_components/user_profile.dart';
import 'package:template/app/utils/helpers/app_helpers.dart';

// binding
part '../../bindings/dashboard_binding.dart';

// controller
part '../../controllers/dashboard_controller.dart';

// model

// component
part '../components/main_menu.dart';
part '../components/member.dart';
part '../components/task_menu.dart';
part '../components/task_in_progress.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(
            flex: 3,
            child: SingleChildScrollView(child: _buildSidebar(context)),
          ),
          Flexible(
            flex: 10,
            child: SingleChildScrollView(child: _buildTaskContent()),
          ),
          Flexible(
            flex: 4,
            child: SingleChildScrollView(child: _buildCalendarContent()),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: UserProfile(
            data: controller.dataProfile,
            onPressed: controller.onPressedProfile,
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _MainMenu(
            onSelected: controller.onSelectedMainMenu,
          ),
        ),
        const Divider(
          indent: 20,
          thickness: 1,
          endIndent: 20,
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: _Member(member: controller.member),
        ),
        const SizedBox(height: kSpacing),
        _TaskMenu(onSelected: controller.onSelectedTaskMenu),
        Padding(
          padding: const EdgeInsets.all(kSpacing),
          child: Text(
            "2021 Teamwork lisence",
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        children: [
          const SizedBox(height: kSpacing),
          SearchField(
            hintText: 'Search Task',
            onSearch: controller.searchTask,
          ),
          const SizedBox(height: kSpacing),
          Row(
            children: [
              HeaderText(DateTime.now().formatdMMMMY()),
              const Spacer(),
              SizedBox(
                width: 200,
                child: TaskProgress(data: controller.dataTask),
              ),
            ],
          ),
          const SizedBox(height: kSpacing),
          _TaskInProgress(data: controller.taskInProgress),
        ],
      ),
    );
  }

  Widget _buildCalendarContent() {
    return Container();
  }
}
