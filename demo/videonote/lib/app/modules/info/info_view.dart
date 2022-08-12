import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../ffi.dart';
import 'info_controller.dart';

class InfoView extends GetView<InfoController> {
  const InfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InfoView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("You're running on"),
            FutureBuilder<List<dynamic>>(
              future: Future.wait([controller.platform, controller.isRelease]),
              builder: (context, snap) {
                final style = Theme.of(context).textTheme.headline4;
                if (snap.error != null) {
                  debugPrint(snap.error.toString());
                  return Tooltip(
                    message: snap.error.toString(),
                    child: Text('Unknown OS', style: style),
                  );
                }

                final data = snap.data;
                if (data == null) return const CircularProgressIndicator();

                final Platform platform = data[0];
                final release = data[1] ? 'Release' : 'Debug';
                final text = const {
                      Platform.Android: 'Android',
                      Platform.Ios: 'iOS',
                      Platform.MacApple: 'MacOS with Apple Silicon',
                      Platform.MacIntel: 'MacOS',
                      Platform.Windows: 'Windows',
                      Platform.Unix: 'Unix',
                      Platform.Wasm: 'the Web',
                    }[platform] ??
                    'Unknown OS';
                return Text('$text ($release)', style: style);
              },
            )
          ],
        ),
      ),
    );
  }
}
