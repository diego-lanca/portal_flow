import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portal_flow/core/core.dart';
import 'package:portal_flow/data/data.dart';

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
  ) async {
    return emit.onEach(
      _authRepository.status,
      onData: (status) async {
        switch (status) {
          case AuthStatus.unauthenticated:
            if (await _tokenRepository.hasToken &&
                !(await _tokenRepository.isTokenExpired)) {
              final user = await _userRepository.fetchUser();

              return emit(AuthState.authenticated(user!));
            } else {
              return emit(const AuthState.unauthenticated());
            }
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

  //// Ativar caso queira debugar estados
  // @override
  // void onChange(Change<AuthState> change) {
  //   debugPrint(change.toString());
  //   super.onChange(change);
  // }

  // @override
  // void onTransition(Transition<AuthEvent, AuthState> transition) {
  //   debugPrint(transition.toString());
  //   super.onTransition(transition);
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   debugPrint('$error, $stackTrace');
  //   super.onError(error, stackTrace);
  // }
}
