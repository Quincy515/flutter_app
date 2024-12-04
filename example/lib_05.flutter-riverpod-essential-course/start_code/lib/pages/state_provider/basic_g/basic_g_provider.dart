import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../basic/basic_provider.dart';

part 'basic_g_provider.g.dart';

@Riverpod(keepAlive: true)
String age(AgeRef ref) {
  final age = ref.watch(counterProvider);

  print('[stateProvider] created');
  ref.onDispose(() {
    print('[stateProvider] dispose');
  });
  return 'Hi! I am $age years old.';
}
