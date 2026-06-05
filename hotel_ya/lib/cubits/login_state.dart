abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final String token;
  AuthLoggedIn({required this.token});
}

class AuthLoggedOut extends AuthState {}

class AuthRegistered extends AuthState {}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}
