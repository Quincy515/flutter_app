import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_code/pages/future_provider/models/user.dart';
import 'package:start_code/pages/future_provider/providers/dio_provider.dart';

// 快捷键 futureProvider 生成 provider
final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  print('[userListProvider] created');
  ref.onDispose(() {
    print('[userListProvider] dispose');
  });
  final response = await ref.watch(dioProvider).get('/users');
  // throw 'Failed to fetch users';
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
});

final userDetailProvider =
    FutureProvider.autoDispose.family<User, int>((ref, id) async {
  print('[userDetailProvider($id)] created');
  ref.onDispose(() {
    print('[userDetailProvider($id)] disposed');
  });
  final response = await ref.watch(dioProvider).get('/users/$id');
  final user = User.fromJson(response.data);
  return user;
});
