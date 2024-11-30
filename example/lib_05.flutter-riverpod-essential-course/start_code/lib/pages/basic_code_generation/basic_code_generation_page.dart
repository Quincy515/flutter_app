import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'basic_code_generation_provider.dart';

class BasicCodeGenerationPage extends ConsumerStatefulWidget {
  const BasicCodeGenerationPage({super.key});

  @override
  ConsumerState<BasicCodeGenerationPage> createState() =>
      _BasicCodeGenerationPageState();
}

class _BasicCodeGenerationPageState
    extends ConsumerState<BasicCodeGenerationPage> {
  @override
  Widget build(BuildContext context) {
    final hello = ref.watch(helloProvider);
    final world = ref.watch(worldProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Provider')),
      body: Center(child: Text('$hello $world')),
    );
  }
}
