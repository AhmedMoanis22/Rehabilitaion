abstract class LoginPatientState {}

class LoginInitial extends LoginPatientState {}

class LoginLoading extends LoginPatientState {}

class LoginSuccess extends LoginPatientState {
  final String uId;

  LoginSuccess({required this.uId});
}

class LoginError extends LoginPatientState {
  final String error;
  LoginError({required this.error});
}
