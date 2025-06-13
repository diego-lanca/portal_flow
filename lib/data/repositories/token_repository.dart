import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:portal_flow/core/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<String?> get token async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<bool> get hasToken async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
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
