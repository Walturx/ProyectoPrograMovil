import 'package:bloc/bloc.dart';
import 'package:hotel_ya/cubits/login_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool get isLoading => state is AuthLoading;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (email.isNotEmpty && password.isNotEmpty) {
        emit(AuthLoggedIn(token: 'token_aqui'));
      } else {
        emit(AuthError(error: 'Usuario y contraseña son obligatorios'));
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
      await Future.delayed(const Duration(seconds: 2));

      if (name.isNotEmpty &&
          phone.isNotEmpty &&
          birthdate.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        emit(AuthLoggedIn(token: 'token_aqui'));
      } else {
        emit(AuthError(error: 'Completa todos los campos'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }
}
