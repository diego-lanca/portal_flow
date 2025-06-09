import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/models/auth_response.dart';
import 'package:portal_flow/data/repositories/token_repository.dart';

/// Authentication repository
class AuthRepository {
  AuthRepository(this._tokenRepository)
    : _dio = Dio(BaseOptions(baseUrl: Env.apiUrl)) {
    if (!kReleaseMode) {
      final adapter = IOHttpClientAdapter();
      adapter.createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      _dio.httpClientAdapter = adapter;
    }
  }

  final _controller = StreamController<AuthStatus>();
  final TokenRepository _tokenRepository;
  late final Dio _dio;

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        'auth/login',
        data: {'email': username, 'password': password},
      );

      if (response.statusCode == 200 && response.data != null) {
        final authResponse = AuthResponse.fromJson(response.data!);
          await _tokenRepository.setToken(authResponse.token);
        _controller.add(AuthStatus.authenticated);

        return;
      }
    } on DioException catch (e) {
      throw Exception('Connection error $e');
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  void logOut() {
    _controller.add(AuthStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
