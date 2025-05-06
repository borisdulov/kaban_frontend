import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kaban_frontend/core/domain/entity/dependency.dart';

final class ApiClient implements Dependency {
  ApiClient({required this.hostUrl}) {
    client = Dio(
      BaseOptions(
        baseUrl: hostUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 10),
        contentType: 'application/json',
      ),
    );

    if (kDebugMode) {
      client.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  late final Dio client;
  final String hostUrl;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await client.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      debugPrint('GET error on $path: $e');
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      return await client.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      debugPrint('POST error on $path: $e');
      rethrow;
    }
  }

  Future testRequest() async {
    try {
      final response = await client.get('/board');
      return response.data;
    } catch (e) {
      debugPrint('Test request error: $e');
      throw Exception('Failed to connect to API server');
    }
  }

  Future testRequest() async {
    try {
      final response = await client.get('/board');
      return response.data;
    } catch (e) {
      throw Exception();
    }
  }
}
