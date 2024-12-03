import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_g_provider.g.dart';

@Riverpod(keepAlive: true)
String age(AgeRef ref) {
  print('[stateProvider] created');
  ref.onDispose(() {
    print('[stateProvider] dispose');
  });
  return '';
}
