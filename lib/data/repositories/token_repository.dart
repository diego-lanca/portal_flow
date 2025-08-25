import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:portal_flow/core/config/config.dart';

class TokenRepository {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> setToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
  }

  Future<String?> get token async {
    return storage.read(key: 'auth_token');
  }

  Future<void> clearToken() async {
    await storage.delete(key: 'auth_token');
  }

  Future<bool> get hasToken async {
    return storage.containsKey(key: 'auth_token');
  }

  Future<bool> get isTokenExpired async {
    final token = await this.token;

    try {
      JWT.verify(token ?? '', SecretKey(Env.jwtTokenKey));

      return false;
    } on JWTExpiredException {
      await clearToken();
      return true;
    } on JWTException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
