abstract class HomeDoctorState {}

class HomeDoctorInitial extends HomeDoctorState {}

class HomeDoctorLoading extends HomeDoctorState {}

class HomeDoctorSuccess extends HomeDoctorState {}

class HomeDoctorError extends HomeDoctorState {
  final String error;
  HomeDoctorError({required this.error});
}

class GetPatientListLoading extends HomeDoctorState {}

class GetPatientListSuccess extends HomeDoctorState {}

class GetPatientListError extends HomeDoctorState {
  final String error;
  GetPatientListError({required this.error});
}

class HomeDoctorPatientDataLoading extends HomeDoctorState {}

class HomeDoctorPatientDataSuccess extends HomeDoctorState {}

class HomeDoctorPatientDataError extends HomeDoctorState {
  final String error;
  HomeDoctorPatientDataError({required this.error});
}

class SendMessageSucess extends HomeDoctorState {}

class SendMessageError extends HomeDoctorState {
  final String error;
  SendMessageError({required this.error});
}

class GetAllMessageSucess extends HomeDoctorState {}
