import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateAutoDisposePage extends ConsumerWidget {
  const StateAutoDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeStateProvider'),
      ),
      body: const Center(
        child: Text('AutoDisposeStateProvider'),
      ),
    );
  }
}
