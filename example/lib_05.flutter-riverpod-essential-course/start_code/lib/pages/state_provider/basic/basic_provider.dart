import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider<int>((ref) {
  print('[stateProvider] created');
  ref.onDispose(() {
    print('[stateProvider] disposed');
  });
  return 0;
});
