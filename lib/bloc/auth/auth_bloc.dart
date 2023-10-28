import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc/repositories/auth/auth_repository.dart';

import 'dart:developer' as dev;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  final AuthRepository _authRepository;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final isSignedIn = await _authRepository.isSignedIn();
      if (isSignedIn) {
        final phoneNo = await _authRepository.getUser();
        emit(Authenticated(phoneNo: phoneNo ?? 'Error'));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    emit(Authenticated(phoneNo: await _authRepository.getUser() ?? 'Error'));
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) {
    emit(UnAuthenticated());
    _authRepository.signOut();
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    dev.log(transition.toString(), name: 'Auth');
    super.onTransition(transition);
  }
}