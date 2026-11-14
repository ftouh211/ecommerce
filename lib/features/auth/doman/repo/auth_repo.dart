import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exeptions/failures.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/doman/entity/sign_up_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure,bool>> signIn(String email, String password);
  Future<Either<Failure, UserModel>> signUp(SignUpEntity signUpEntity);
}
