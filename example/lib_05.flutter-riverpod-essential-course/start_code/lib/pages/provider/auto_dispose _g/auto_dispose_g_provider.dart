import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_dispose_g_provider.g.dart';

@riverpod
String autoDisposeHello(AutoDisposeHelloRef ref) {
  print('[autoDisposeHelloProvider] created');
  ref.onDispose(() {
    print('[autoDisposeHelloProvider] disposed');
  });
  return 'Hello';
}
