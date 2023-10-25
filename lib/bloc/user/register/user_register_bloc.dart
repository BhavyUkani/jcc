import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc/models/user_model.dart';
import 'package:jcc/repositories/user_repository.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

class UserRegisterBloc extends Bloc<UserRegisterEvent, UserRegisterState> {
  UserRegisterBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(UserRegisterInitial()) {
    on<RegisterUser>(_onRegisterUser);
    on<UnRegisterUser>(_onUnRegisterUser);
    on<GetUser>(_onGetUser);
    on<UpdateUser>(_onUpdateUser);
    on<InitializeUser>(_onInitializeUser);
  }

  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;

  void _onInitializeUser(InitializeUser event, Emitter<UserRegisterState> emit) {
    _userSubscription?.cancel();
    emit(UserRegisterInitial());
  }

  Future<void> _onRegisterUser(RegisterUser event, Emitter<UserRegisterState> emit,) async {
    emit(UserRegistering());
    final user = await _userRepository.registerUser(event.user);

    if (user == null) {
      emit(const UserRegisterError('Some error occurred!'));
    }else {
      emit(UserRegistered(user));
    }
  }

  void _onUpdateUser(UpdateUser event, Emitter<UserRegisterState> emit) {
    emit(UserRegistered(event.user));
  }

  Future<void> _onGetUser(GetUser event, Emitter<UserRegisterState> emit) async {
    emit(GettingUser());
    try {
      _userSubscription?.cancel();
      _userSubscription =
          _userRepository.getUserStream(event.userId).listen((event) {
            if (event == null) {
              dev.log('User is null', name: 'User');
              add(UnRegisterUser());
            } else {
              add(UpdateUser(user: event));
            }
          });
    } on FirebaseException catch (e) {
      dev.log('Error in registering: ${e.code}', name: 'User');
      emit(UserError(e.toString()));
    }
  }

  void _onUnRegisterUser(UnRegisterUser event, Emitter<UserRegisterState> emit) {
    _userSubscription?.cancel();
    emit(UserNotRegistered());
  }

  @override
  void onTransition(Transition<UserRegisterEvent, UserRegisterState> transition) {
    dev.log(transition.toString(), name: 'User');
    super.onTransition(transition);
  }
}
