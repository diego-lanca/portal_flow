import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:portal_flow/data/models/user.dart';
import 'package:portal_flow/data/repositories/token_repository.dart';

class UserRepository {
  UserRepository(this._tokenRepository);

  User? _user;
  final TokenRepository _tokenRepository;

  Future<User?> get user async {
    if (_user != null) return _user;

    // Usuário não autenticado
    final user = await fetchUser();
    _user = user;
    return user;
  }

  Future<User?> fetchUser() async {
    try {
      final token = await _tokenRepository.token;

      if (token != null) {
        final jwt = JWT.decode(token);
      
        final user = User.fromToken(jwt.payload as Map<String, dynamic>);
        return user;
      }

      return null;

    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Exception('Error fetching user');
    }
  }

  void clearUser() {
    _user = null;
  }
}
