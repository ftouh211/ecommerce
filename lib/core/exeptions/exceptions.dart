// abstract class MyExceptions {
//   String message;
//   MyExceptions(this.message);
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return message;
//   }
// }
//
// class MyLocalExceptions extends MyExceptions {
//   MyLocalExceptions(super.message);
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return super.message;
//   }
// }
//
// class MyRemoteExceptions extends MyExceptions {
//   MyRemoteExceptions(super.message);
//
//   @override
//   String toString() {
//     // TODO: implement toString
//     return super.message;
//   }
// }


import 'package:dio/dio.dart';
import 'package:ecommerce_app/config/api/status_codes.dart';

abstract class MyExceptions implements Exception {
  final String message;

  MyExceptions(this.message);

  @override
  String toString() => message;
}

class MyLocalExceptions extends MyExceptions {
  MyLocalExceptions(super.message);
}

class MyRemoteExceptions extends MyExceptions {
  MyRemoteExceptions(super.message);
}

class DioExceptionHandler {
  static MyRemoteExceptions handleDioException(
      DioException exception) {
    switch (exception.response?.statusCode) {
      case StatusCodes.clientError:
        return MyRemoteExceptions(
          exception.response?.data['message'] ?? 'Bad Request',
        );

      case StatusCodes.unAuthorized:
        return MyRemoteExceptions(
          exception.response?.data['message'] ?? 'Unauthorized',
        );

      case StatusCodes.forbidden:
        return MyRemoteExceptions('You are not allowed to access this resource');

      case StatusCodes.notFound:
        return MyRemoteExceptions('Resource Not Found');

      case StatusCodes.conflict:
        return MyRemoteExceptions('Conflict Error');

      case StatusCodes.unprocessableEntity:
        return MyRemoteExceptions('Unprocessable Entity');

      case StatusCodes.serverError:
      case StatusCodes.badGateway:
      case StatusCodes.serviceUnavailable:
      case StatusCodes.gatewayTimeout:
        return MyRemoteExceptions('Server Error. Please try again later.');

      default:
        if (exception.type == DioExceptionType.connectionTimeout ||
            exception.type == DioExceptionType.sendTimeout ||
            exception.type == DioExceptionType.receiveTimeout) {
          return MyRemoteExceptions('Connection Timeout');
        }

        if (exception.type == DioExceptionType.connectionError ||
            exception.type == DioExceptionType.unknown) {
          return MyRemoteExceptions('No Internet Connection');
        }

        return MyRemoteExceptions(
          exception.message ?? 'Something went wrong',
        );
    }
  }
}