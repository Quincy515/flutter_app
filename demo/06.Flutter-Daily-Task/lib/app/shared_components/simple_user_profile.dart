import 'package:flutter/material.dart';
import 'package:template/app/constans/app_constants.dart';
import 'package:template/app/utils/helpers/app_helpers.dart';

class SimpleUserProfile extends StatelessWidget {
  const SimpleUserProfile({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildAvatar(),
      title: _buildName(),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.more_horiz),
        splashRadius: 24,
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.orange.withOpacity(.2),
      child: Text(
        name.getInitialName(),
        style: const TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildName() {
    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kFontColorPallets[0],
        fontSize: 13,
      ),
    );
  }
}
