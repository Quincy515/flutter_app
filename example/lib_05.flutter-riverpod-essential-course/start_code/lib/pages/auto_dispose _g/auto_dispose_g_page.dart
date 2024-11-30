import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auto_dispose_g_provider.dart';

class AutoDisposeGPage extends ConsumerWidget {
  const AutoDisposeGPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hello = ref.watch(autoDisposeHelloProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeProvider'),
      ),
      body: Center(
        child: Text(
          hello,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
