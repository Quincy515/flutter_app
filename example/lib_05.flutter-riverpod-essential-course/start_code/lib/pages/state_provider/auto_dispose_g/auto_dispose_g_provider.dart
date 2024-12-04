import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auto_dispose/auto_dispose_provider.dart';

part 'auto_dispose_g_provider.g.dart';

@riverpod
String autoDisposeAge(AutoDisposeAgeRef ref) {
  final age = ref.watch(autoDisposeCounterProvider);
  print('[autoDisposeAge] created');
  ref.onDispose(() {
    print('[autoDisposeAge] disposed');
  });
  return 'Hi! I am $age years old.';
}
