import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  const AuthResponse({
    this.token = '',
    this.isSuccess = false,
    this.message = '',
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String
    );
  }
  
  final String token;
  final bool isSuccess;
  final String? message;

  @override
  List<Object?> get props => [token, isSuccess, message];

}
