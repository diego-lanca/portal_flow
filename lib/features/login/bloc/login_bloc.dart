import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:portal_flow/data/data.dart';
import 'package:portal_flow/features/login/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required TokenRepository tokenRepository,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _tokenRepository = tokenRepository,
       super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final TokenRepository _tokenRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.password, password]),
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        final clientPortal = await _authRepository.clientPortalAccess(
          username: state.username.value,
        );

        if (clientPortal) {
          await _authRepository.logIn(
            username: state.username.value,
            password: state.password.value,
          );

          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }

        // Fails
      } on DioException catch (e) {
        await _tokenRepository.clearToken();
        _userRepository.clearUser();
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
        emit(state.copyWith(status: FormzSubmissionStatus.canceled));
      }
    }
  }
}
