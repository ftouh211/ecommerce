// part of 'auth_bloc.dart';
//
// abstract class AuthState {}
//
// final class AuthInitial extends AuthState {}
//
// class AuthLoginState extends AuthState {
//   RequestState requestState;
//   AuthLoginState(this.requestState);
// }
//
// enum RequestState { loading, success, error }

import 'package:ecommerce_app/core/utils/enums.dart';

class AuthLoginState {
  RequestState? requestState;
  String? errorMessage;
  bool? loggedIn;

  AuthLoginState({this.requestState, this.errorMessage, this.loggedIn});

  AuthLoginState copyWith(
      {RequestState? requestState, String? errorMessage, bool? loggedIn}) {
    return AuthLoginState(
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
        loggedIn: loggedIn ?? this.loggedIn);
  }
}

class AuthLoginInit extends AuthLoginState {
  AuthLoginInit()
      : super(
            requestState: RequestState.init,
            loggedIn: false,
            errorMessage: "error_init_login");
}

class AuthSignUpState {
  RequestState? requestState;
  String? errorMessage;
  bool? signedUp;

  AuthSignUpState({this.requestState, this.errorMessage, this.signedUp});

  AuthSignUpState copyWith(
      {RequestState? requestState, String? errorMessage, bool? signedUp}) {
    return AuthSignUpState(
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
        signedUp: signedUp ?? this.signedUp);
  }
}

class AuthSignUpInit extends AuthSignUpState {
  AuthSignUpInit()
      : super(
            requestState: RequestState.init,
            signedUp: false,
            errorMessage: "error_init_login");
}
