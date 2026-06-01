import 'package:bloc/bloc.dart';
import 'package:hotel_ya/cubits/recovery_state.dart';
import 'package:hotel_ya/services/recovery_service.dart';

class RecoveryCubit extends Cubit<RecoveryState> {
  RecoveryCubit() : super(RecoveryInitial());
  final RecoveryService _recoveryService = RecoveryService();
  bool get isLoading => state is RecoveryLoading;

  Future<void> sendCode(String email) async {
    emit(RecoveryLoading());
    try {
      final response = await _recoveryService.sendCode(email);
      if (response.success) {
        emit(RecoveryCodeSent(token: response.data!));
      } else {
        emit(RecoveryError(error: response.message));
      }
    } catch (e) {
      emit(RecoveryError(error: e.toString()));
    }
  }

  Future<void> validateCode(String token, String code) async {
    emit(RecoveryLoading());
    try {
      final response = await _recoveryService.validateCode(token, code);
      if (response.success) {
        emit(RecoveryCodeValidated(token: response.data!));
      } else {
        emit(RecoveryError(error: response.message));
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
      final response = await _recoveryService.changePassword(
        token,
        newPassword,
        confirmPassword,
      );
      if (response.success) {
        emit(RecoveryPasswordChanged(token: response.data!));
      } else {
        emit(RecoveryError(error: response.message));
      }
    } catch (e) {
      emit(RecoveryError(error: e.toString()));
    }
  }

  void sendRecoveryCode(String text) {}
}
