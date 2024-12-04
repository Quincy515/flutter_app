import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_code/pages/state_provider/auto_dispose/auto_dispose_provider.dart';

class StateAutoDisposePage extends ConsumerWidget {
  const StateAutoDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(autoDisposeCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeStateProvider'),
      ),
      body: Center(
        child: Text('$value', style: Theme.of(context).textTheme.headlineLarge),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(autoDisposeCounterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
