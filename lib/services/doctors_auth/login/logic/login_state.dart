abstract class LoginDocotorState {}

class LoginInitial extends LoginDocotorState {}

class LoginLoading extends LoginDocotorState {}

class LoginSuccess extends LoginDocotorState {
  final String uId;

  LoginSuccess(this.uId);
}

class LoginError extends LoginDocotorState {
  final String error;
  LoginError({required this.error});
}
