import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyHelloProvider = Provider.family<String, String>((ref, name) {
  print('[familyHelloProvider] created $name');
  ref.onDispose(() {
    print('[familyHelloProvider] dispose $name');
  });
  return 'Hello $name';
});
