import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/utils/enums.dart';
import 'package:ecommerce_app/features/auth/doman/entity/sign_up_entity.dart';
import 'package:ecommerce_app/features/auth/doman/use_cases/login_usecase.dart';
import 'package:ecommerce_app/features/auth/doman/use_cases/signup_usecase.dart';
import 'package:meta/meta.dart';

import 'auth_state.dart';

part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthLoginState> {
  LoginUseCase loginUseCase;
  SignupUseCase signupUseCase;

  AuthBloc(this.loginUseCase, this.signupUseCase) : super(AuthLoginInit()) {
    on<AuthEvent>((event, emit) {});

    // on<LoginEvent>((event, emit) async {
    //   state.copyWith(requestState: RequestState.loading);
    //
    //   bool loggedIn = await loginUseCase.call(event.email, event.password);
    //   if (loggedIn) {
    //     emit(
    //       state.copyWith(loggedIn: true, requestState: RequestState.success),
    //     );
    //   } else {
    //     emit(state.copyWith(
    //         requestState: RequestState.error,
    //         loggedIn: false,
    //         errorMessage: "login_Something went wrong"));
    //   }
    // });

    on<LoginEvent>((event, emit) async {
      emit(state.copyWith(requestState: RequestState.loading));

      final result = await loginUseCase.call(
        event.email,
        event.password,
      );

      result.fold(
        (failure) {
          emit(state.copyWith(
            requestState: RequestState.error,
            loggedIn: false,
            errorMessage: failure.message,
          ));
        },
        (loggedIn) {
          emit(state.copyWith(
            requestState: loggedIn ? RequestState.success : RequestState.error,
            loggedIn: loggedIn,
            errorMessage: loggedIn ? null : "Login failed",
          ));
        },
      );
    });

    on<SignupEvent>(
      (event, emit) async {
        emit(state.copyWith(requestState: RequestState.loading));

        final result = await signupUseCase.call(event.signUpEntity);

        result.fold(
          (l) {
            emit(state.copyWith(
              requestState: RequestState.error,
            ));
          },
          (r) {
            emit(state.copyWith(requestState: RequestState.success));
          },
        );
      },
    );
  }
}
