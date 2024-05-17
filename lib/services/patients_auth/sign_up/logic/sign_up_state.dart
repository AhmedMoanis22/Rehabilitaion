abstract class SignUpPatientState {}

class SignUpInitial extends SignUpPatientState {}

class SignUpLoading extends SignUpPatientState {}

class SignUpSuccess extends SignUpPatientState {}

class SignUpError extends SignUpPatientState {
  final String error;
  SignUpError({required this.error});
}

class CreateUserPatientSuccess extends SignUpPatientState {}

class CreateUserPatientError extends SignUpPatientState {
  final String error;
  CreateUserPatientError({required this.error});
}
