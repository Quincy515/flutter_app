import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateFamilyGPage extends ConsumerWidget {
  const StateFamilyGPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FamilyStateProvider'),
      ),
      body: const Center(
        child: Text('FamilyStateProvider'),
      ),
    );
  }
}
