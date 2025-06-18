abstract base class AuthState {}

final class AuthCubitLoading implements AuthState {}

final class AuthCubitAuthorized implements AuthState {}

final class AuthCubitUnauthorized implements AuthState {}
