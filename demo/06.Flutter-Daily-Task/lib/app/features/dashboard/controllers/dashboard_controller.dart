part of dashboard;

class DashboardController extends GetxController {
  final UserProfileData dataProfile = const UserProfileData(
    image: AssetImage(ImageRasterPath.man),
    name: "Custer",
    jobDesk: "Project Manager",
  );

  final member = ["Avril Kimberly", "Michael Greg"];

  final dataTask = const TaskProgressData(totalCompleted: 1, totalTasks: 5);

  final taskInProgress = [
    CardTaskData(
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
      jobDesk: 'System Analyst',
      label: 'Datermine meeting schedule',
    ),
    CardTaskData(
      dueDate: DateTime.now().add(const Duration(hours: 4)),
      jobDesk: 'Marketing',
      label: 'Personal branding',
    ),
    CardTaskData(
      dueDate: DateTime.now().add(const Duration(days: 2)),
      jobDesk: 'Design',
      label: 'UI UX',
    ),
    CardTaskData(
      dueDate: DateTime.now().add(const Duration(minutes: 50)),
      jobDesk: 'System Analyst',
      label: 'Datermine meeting schedule',
    ),
  ];

  void onPressedProfile() {}

  void onSelectedMainMenu(int index, SelectionButtonData value) {}

  void onSelectedTaskMenu(int index, String label) {}

  void searchTask(String value) {}
}
