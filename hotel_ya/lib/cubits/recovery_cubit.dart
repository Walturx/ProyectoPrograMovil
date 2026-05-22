import 'package:bloc/bloc.dart';
import 'package:hotel_ya/cubits/recovery_state.dart';

class RecoveryCubit extends Cubit<RecoveryState> {
  RecoveryCubit() : super(RecoveryInitial());
  bool get isLoading => state is RecoveryLoading;

  Future<void> sendCode(String email) async {
    emit(RecoveryLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (email.isNotEmpty) {
        emit(RecoveryCodeSent(token: 'token_aqui'));
      } else {
        emit(RecoveryError(error: 'Es necesario un correo electronico'));
      }
    } catch (e) {
      emit(RecoveryError(error: e.toString()));
    }
  }

  Future<void> validateCode(String token, String code) async {
    emit(RecoveryLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (token.isNotEmpty && code.isNotEmpty) {
        emit(RecoveryCodeValidated(token: 'token_aqui'));
      } else {
        emit(RecoveryError(error: 'Completa todos los campos'));
      }
    } catch (e) {
      emit(RecoveryError(error: e.toString()));
    }
  }

  Future<void> changePassword(
    String token,
    String newPassword,
    String confirmPassword,
  ) async {
    emit(RecoveryLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      if (token.isNotEmpty &&
          newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty) {
        if (newPassword == confirmPassword) {
          emit(RecoveryPasswordChanged(token: 'token_aqui'));
        } else {
          emit(RecoveryError(error: 'Las contraseñas no coinciden'));
        }
      } else {
        emit(RecoveryError(error: 'Completa todos los campos'));
      }
    } catch (e) {
      emit(RecoveryError(error: e.toString()));
    }
  }

  void sendRecoveryCode(String text) {}
}
