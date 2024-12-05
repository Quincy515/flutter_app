import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 快捷键 riverpodPart 生成 g.dart 文件
part 'dio_provider.g.dart';

// 快捷键 riverpod 生成 provider
@riverpod
Dio dio(DioRef ref) {
  return Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
}
