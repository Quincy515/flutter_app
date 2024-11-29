import 'package:flutter_riverpod/flutter_riverpod.dart';

final autoDisposeFamilyHelloProvider =
    Provider.autoDispose.family<String, String>((ref, name) {
  print('[autoDisposeFamilyHelloProvider] created $name');
  ref.onDispose(() {
    print('[autoDisposeFamilyHelloProvider] dispose $name');
  });
  return 'Hello $name';
});
