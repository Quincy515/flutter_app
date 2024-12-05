import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyCounterProvider =
    StateProvider.family<int, int>((ref, initialvalue) {
  print('[familyCounterProvider($initialvalue)] created');
  ref.onDispose(() {
    print('[familyCounterProvider($initialvalue)] disposed');
  });
  return initialvalue;
});
