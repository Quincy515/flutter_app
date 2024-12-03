import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_code/pages/provider/auto_dispose_family_multipe_params/auto_dispose_family_multipe_params_provider.dart';

class AutoDisposeFamilyTestPage extends ConsumerStatefulWidget {
  const AutoDisposeFamilyTestPage({super.key});

  @override
  ConsumerState<AutoDisposeFamilyTestPage> createState() =>
      _AutoDisposeFamilyTestPageState();
}

class _AutoDisposeFamilyTestPageState
    extends ConsumerState<AutoDisposeFamilyTestPage> {
  String name = 'john';

  @override
  Widget build(BuildContext context) {
    final helloThere = ref.watch(autoDisposeFamilyTestHelloProvider(name));

    final count1 = ref.watch(counterProvider(Counter(count: 1)));
    final count2 = ref.watch(counterProvider(Counter(count: 1)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDisposeFamilyProvider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$helloThere $count1, $count2',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                setState(() {
                  name = name == 'john' ? 'jane' : 'john';
                });
              },
              child: const Text(
                'Change Name',
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
