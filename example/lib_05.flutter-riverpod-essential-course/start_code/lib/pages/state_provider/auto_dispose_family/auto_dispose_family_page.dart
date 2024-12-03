import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateAutoDisposeFamilyPage extends ConsumerWidget {
  const StateAutoDisposeFamilyPage({super.key});

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
