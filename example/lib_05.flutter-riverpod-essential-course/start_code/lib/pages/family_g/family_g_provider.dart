import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'family_g_provider.g.dart';

@Riverpod(keepAlive: true)
String familyHello(FamilyHelloRef ref, {required String there}) {
  print('[familyHelloProvider($there)] created');
  ref.onDispose(() {
    print('[familyHelloProvider($there)] disposed');
  });
  return 'Hello $there';
}
