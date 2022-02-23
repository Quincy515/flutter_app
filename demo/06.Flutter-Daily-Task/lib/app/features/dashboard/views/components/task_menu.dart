part of dashboard;

class _TaskMenu extends StatelessWidget {
  const _TaskMenu({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  final Function(int index, String value) onSelected;

  @override
  Widget build(BuildContext context) {
    return SimpleSelectionButton(
      data: const ["Directory", "Onboarding", "Offboarding", "Time-off"],
      onSelected: onSelected,
    );
  }
}
