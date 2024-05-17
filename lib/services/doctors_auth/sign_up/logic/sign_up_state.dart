abstract class SignUpDoctorState {}

class SignUpInitial extends SignUpDoctorState {}

class SignUpLoading extends SignUpDoctorState {}

class SignUpSuccess extends SignUpDoctorState {}

class SignUpError extends SignUpDoctorState {
  final String error;
  SignUpError({required this.error});
}

class CretaeUserSuccess extends SignUpDoctorState {}

class CretaeUserFaluire extends SignUpDoctorState {
  final String error;

  CretaeUserFaluire({required this.error});
}
