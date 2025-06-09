import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/data/repositories/token_repository.dart';
import 'package:portal_flow/features/auth/auth.dart';
import 'package:portal_flow/features/home/home.dart';
import 'package:portal_flow/features/login/login.dart';
import 'package:portal_flow/features/splash/splash.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => TokenRepository()),
        RepositoryProvider(
          create: (context) => AuthRepository(context.read<TokenRepository>()),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(context.read<TokenRepository>()),
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => AuthBloc(
          authRepository: context.read<AuthRepository>(),
          userRepository: context.read<UserRepository>(),
          tokenRepository: context.read<TokenRepository>(),
        )..add(AuthSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthStatus.unknown:
                break;
              case AuthStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
