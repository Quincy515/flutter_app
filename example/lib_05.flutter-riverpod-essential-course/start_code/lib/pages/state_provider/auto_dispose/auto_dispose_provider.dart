import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoDisposeCounterProvider = StateProvider.autoDispose<int>((ref) {
  print('[autoDisposeCounterProvider] created');
  ref.onDispose(() {
    print('[autoDisposeCounterProvider] disposed');
  });
  return 0;
});
