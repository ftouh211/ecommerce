import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exeptions/failures.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/doman/entity/sign_up_entity.dart';
import 'package:ecommerce_app/features/auth/doman/repo/auth_repo.dart';

class SignupUseCase {
  AuthRepo repo;
  SignupUseCase(this.repo);

  Future<Either<Failure, UserModel>> call(SignUpEntity signUpEntity) =>
      repo.signUp(signUpEntity);
}
