import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_streaming.dart';
import 'package:ecommerce_app/core/exeptions/failures.dart';
import 'package:ecommerce_app/features/auth/data/date_sorces/remote/auth_remote_ds.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/doman/entity/sign_up_entity.dart';
import 'package:ecommerce_app/features/auth/doman/repo/auth_repo.dart';

class AuthRepoImple implements AuthRepo {
  AuthRemoteDs authRemoteDs;
  AuthRepoImple(this.authRemoteDs);
  @override
  Future<Either<Failure, bool>> signIn(String email, String password) async {
    try {
      bool loggedIn = await authRemoteDs.signIn(email, password);

      if (!loggedIn) {
        return Left(AuthFailure("Invaild username or password"));
      }
      return Right(loggedIn);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUp(SignUpEntity signUpEntity) async {
    try {
      final userModel = await authRemoteDs.signUp(signUpEntity);

      return Right(userModel);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
