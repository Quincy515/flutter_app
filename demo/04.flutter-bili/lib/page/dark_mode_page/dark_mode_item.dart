import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/provider/index.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/util/view_util.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DarkModeItem extends StatelessWidget {
  const DarkModeItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var icon = themeProvider.isDark()
        ? Icons.nightlight_round
        : Icons.wb_sunny_rounded;
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, Routes.dark,
            transition: TransitionType.cupertino);
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 15, bottom: 15),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(border: borderLine(context)),
        child: Row(
          children: [
            Text(
              S.of(context).darkMode,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2, left: 10),
              child: Icon(icon),
            ),
          ],
        ),
      ),
    );
  }
}
