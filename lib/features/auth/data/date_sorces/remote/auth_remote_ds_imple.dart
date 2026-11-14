import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/config/api/api_manager.dart';
import 'package:ecommerce_app/config/api/end_points.dart';
import 'package:ecommerce_app/config/api/status_codes.dart';
import 'package:ecommerce_app/core/exeptions/exceptions.dart';
import 'package:ecommerce_app/core/exeptions/failures.dart';
import 'package:ecommerce_app/features/auth/data/date_sorces/remote/auth_remote_ds.dart';
import 'package:ecommerce_app/features/auth/data/models/user_model.dart';
import 'package:ecommerce_app/features/auth/doman/entity/sign_up_entity.dart';

// class AuthRemoteDsImple implements AuthRemoteDs {
//
//   ApiManager apiManager;
//   AuthRemoteDsImple(this.apiManager);
//   // هنا بقا اقدر اكلم ال APi بتاعي
//   @override
//   Future<bool> signIn(String email, String password) async {
//     // call Api login
//
//     // final response = await dio.post(
//     //   "https://ecommerce.routemisr.com/api/v1/auth/signin",
//     //   data: {"email": email, "password": password},
//     // );
//     // if (response.statusCode == 200) {
//     //   return true;
//     // } else {
//     //   return false;
//     // }
//
//     final response = await ApiManager().postData(
//         endPoint: EndPoints.signIn,
//         body: {"email": email, "password": password});
//
//     if (response.statusCode == StatusCodes.success) {
//       return true;
//     } else {
//       return false;
//     }
//   }
//
//   @override
//   Future<UserModel> signUp(SignUpEntity signUpEntity) async {
//     final response = await ApiManager()
//         .postData(endPoint: EndPoints.signUp, body: signUpEntity.toJson());
//
//     UserModel userModel = UserModel.fromJson(response.data);
//     return userModel;
//   }
//
//   // @override
//   // Future<UserModel> signUp(SignUpEntity signUpEntity) async {
//   //   final response =
//   //       await dio.post("/api/v1/auth/signup", data: signUpEntity.toJson());
//   //   if (response.statusCode == StatusCodes.success) {
//   //     return UserModel();
//   //   } else {
//   //     return false;
//   //   }
//   // }
// }

class AuthRemoteDsImple implements AuthRemoteDs {
  final ApiManager apiManager;

  AuthRemoteDsImple(this.apiManager);

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      final response = await apiManager.postData(
        endPoint: EndPoints.signIn,
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == StatusCodes.success) {
        return true;
      }

      throw MyRemoteExceptions('Login failed');
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }

  @override
  Future<UserModel> signUp(SignUpEntity signUpEntity) async {
    try {
      final response = await apiManager.postData(
        endPoint: EndPoints.signUp,
        body: signUpEntity.toJson(),
      );

      if (response.statusCode == StatusCodes.success ||
          response.statusCode == StatusCodes.successCreated) {
        return UserModel.fromJson(response.data);
      }

      throw MyRemoteExceptions('Registration failed');
    } on DioException catch (e) {
      throw DioExceptionHandler.handleDioException(e);
    }
  }
}