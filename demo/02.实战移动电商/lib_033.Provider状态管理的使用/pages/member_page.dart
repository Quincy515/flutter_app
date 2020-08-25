import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/counter.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        /// Calls `context.watch` to make [MyHomePage] rebuild when [Counter] changes.
        '${context.watch<Counter>().value}',
        style: Theme.of(context).textTheme.headline1,
      ),
    ));
  }
}
