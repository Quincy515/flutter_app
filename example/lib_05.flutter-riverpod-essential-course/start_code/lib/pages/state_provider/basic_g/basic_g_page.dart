import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateBasicGPage extends ConsumerWidget {
  const StateBasicGPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: const Center(
        child: Text('StateProvider'),
      ),
    );
  }
}
