import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/data/repositories/token_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required TokenRepository tokenRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _tokenRepository = tokenRepository,
       super(const AuthState.unknown()) {
    on<AuthSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthLogoutPressed>(_onLogoutPressed);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;

  Future<void> _onSubscriptionRequested(
    AuthSubscriptionRequested event,
    Emitter<AuthState> emit,
  ) {
    return emit.onEach(
      _authRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthStatus.unauthenticated:
            return emit(const AuthState.unauthenticated());
          case AuthStatus.authenticated:
            final user = await _tryGetUser();
            return emit(
              user != null
                  ? AuthState.authenticated(user)
                  : const AuthState.unauthenticated(),
            );
          case AuthStatus.unknown:
            return emit(const AuthState.unknown());
        }
      },
      onError: addError,
    );
  }

  void _onLogoutPressed(
    AuthLogoutPressed event,
    Emitter<AuthState> emit,
  ) {
    _authRepository.logOut();
    _tokenRepository.clearToken();
    _userRepository.clearUser();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.user;
      return user;
    } on Exception catch (_) {
      throw Exception('Could not get user.');
    }
  }
}
