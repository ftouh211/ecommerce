import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/exeptions/failures.dart';
import 'package:ecommerce_app/features/auth/doman/repo/auth_repo.dart';

class LoginUseCase {
  AuthRepo repo;
  LoginUseCase(this.repo);

  Future<Either<Failure, bool>> call(String email, String password) =>
      repo.signIn(email, password);
}
