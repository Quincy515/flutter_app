import 'package:riverpod_annotation/riverpod_annotation.dart';

// 快捷键 riverpodPart
part 'basic_code_generation_provider.g.dart';

// keepAlive: true 表示 Riverpod_generator 不要应用 autoDispose 修饰符
@Riverpod(keepAlive: true)
String hello(HelloRef ref) {
  print('[hello] created');
  ref.onDispose(() {
    print('[hello] disposed');
  });
  return 'Hello';
}

@Riverpod(keepAlive: true)
String world(WorldRef ref) {
  print('[world] created');
  ref.onDispose(() {
    print('[world] disposed');
  });
  return 'World!';
}
