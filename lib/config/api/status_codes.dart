class StatusCodes {
  static const int success = 200;
  static const int successCreated = 201;
  static const int successNoContent = 204;

  static const int clientError = 400;
  static const int unAuthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int unprocessableEntity = 422;

  static const int serverError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
  static const int gatewayTimeout = 504;
}