import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/data/repositories/token_repository.dart';
import 'package:portal_flow/features/login/bloc/login_bloc.dart';
import 'package:portal_flow/features/login/view/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/contabil-logo-horizontal.png'),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: BlocProvider(
                      create: (context) => LoginBloc(
                        authRepository: context.read<AuthRepository>(),
                        userRepository: context.read<UserRepository>(),
                        tokenRepository: context.read<TokenRepository>(),
                      ),
                      child: const LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
