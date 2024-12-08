import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_code/pages/future_provider/users_providers.dart';

class UserDetailPage extends ConsumerWidget {
  final int userId;

  const UserDetailPage({required this.userId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetail = ref.watch(userDetailProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Detail'),
      ),
      body: const Center(
        child: Text('User Detail'),
      ),
    );
  }
}
