abstract base class AuthCubitState {}

final class AuthCubitLoading implements AuthCubitState {}

final class AuthCubitAuthorized implements AuthCubitState {}

final class AuthCubitUnauthorized implements AuthCubitState {}
