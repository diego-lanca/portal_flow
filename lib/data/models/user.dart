import 'package:equatable/equatable.dart';

/// Usuário com acesso ao client portal
class User extends Equatable {
  /// Constructor
  const User(
    this.name,
    this.cpf,
    this.email,
    this.phone,
    this.companyId,
    this.groupId, 
    this.roles, {
    this.id,
    this.isActive = false,
  });

  /// Empty constructor
  const User.empty({
    this.id = '',
    this.name = '',
    this.cpf = '',
    this.email = '',
    this.phone = '',
    this.companyId = 0,
    this.groupId = 0,
    this.isActive = false,
    this.roles
  });

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     json['name'] as String,
  //     '',
  //     json['email'] as String,
  //     '',
  //     int.parse(json['companyid'] as String),
  //     0,
  //     json['role'] as List<String>,
  //     id: json['nameId'] as String
  //   );
  // }

  factory User.fromToken(Map<String, dynamic> token) {
    try {
      final roles = token['role'] as List<dynamic>;
      return User(
        token['name'] as String,
        '',
        token['email'] as String,
        '',
        int.parse(token['companyid'] as String),
        0,
        roles.cast<String>(),
        id: token['nameid'] as String
      );
    } on Exception catch (_) {
      rethrow;
    } 
  }
  
  ///User props
  final String? id;
  final String name;
  final String cpf;
  final String email;
  final String phone;
  final List<String>? roles;
  final int companyId;
  final int groupId;
  final bool isActive;
  // final String? profileImage;

  @override
  List<Object> get props => [
    id ?? 0,
    name,
    cpf,
    email,
    phone,
    companyId,
    groupId,
    isActive,
  ];

}
