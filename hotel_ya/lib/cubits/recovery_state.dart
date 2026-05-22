abstract class RecoveryState {}

class RecoveryInitial extends RecoveryState {}

class RecoveryLoading extends RecoveryState {}

class RecoveryCodeSent extends RecoveryState {
  final String token;
  RecoveryCodeSent({required this.token});
}

class RecoveryCodeError extends RecoveryState {
  final String error;
  RecoveryCodeError({required this.error});
}

class RecoveryCodeValidated extends RecoveryState {
  final String token;
  RecoveryCodeValidated({required this.token});
}

class RecoveryPasswordChanged extends RecoveryState {
  final String token;
  RecoveryPasswordChanged({required this.token});
}

class RecoveryError extends RecoveryState {
  final String error;
  RecoveryError({required this.error});
}
