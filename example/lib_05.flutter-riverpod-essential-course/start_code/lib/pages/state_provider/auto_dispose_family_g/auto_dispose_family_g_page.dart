import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateAutoDisposeFamilyGPage extends ConsumerWidget {
  const StateAutoDisposeFamilyGPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeFamilyStateProvider'),
      ),
      body: const Center(
        child: Text('AutoDisposeFamilyStateProvider'),
      ),
    );
  }
}
