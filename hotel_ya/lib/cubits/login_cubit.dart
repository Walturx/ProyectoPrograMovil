import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:hotel_ya/cubits/login_state.dart';
import 'package:hotel_ya/services/auth_service.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();
  AuthCubit() : super(AuthInitial());
  bool get isLoading => state is AuthLoading;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final response = await _authService.loginWithEmail(email, password);

      if (response.success) {
        emit(AuthLoggedIn(token: response.data!.id));
      } else {
        emit(AuthError(error: response.message));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  Future<void> register(
    String name,
    String phone,
    String birthdate,
    String email,
    String password,
  ) async {
    emit(AuthLoading());
    try {
      final response = await _authService.registerWithEmail(email, password);
      if (response.success) {
        emit(AuthLoggedIn(token: response.data!.id));
      } else {
        emit(AuthError(error: response.message));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
