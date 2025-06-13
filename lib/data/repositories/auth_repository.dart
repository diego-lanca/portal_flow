import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/models/models.dart';
import 'package:portal_flow/data/repositories/token_repository.dart';
import 'package:portal_flow/http.dart';

/// Authentication repository
class AuthRepository {
  AuthRepository(this._tokenRepository);

  final _controller = StreamController<AuthStatus>();
  final TokenRepository _tokenRepository;

  Stream<AuthStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<bool> clientPortalAccess({
    required String username,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'auth/portal',
        options: Options(
          headers: {
            'email': username,
          },
        ),
      );

      // Supondo que o backend retorne algo como { "success": true }
      return response.data?['success'] == true;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post<Map<String, dynamic>>(
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
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout, please contact support');
      }

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
