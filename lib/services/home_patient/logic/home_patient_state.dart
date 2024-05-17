abstract class HomePatientState {}

class HomePatientInitial extends HomePatientState {}

class HomePatientLoading extends HomePatientState {}

class HomePatientSuccess extends HomePatientState {}

class HomePatientError extends HomePatientState {
  final String error;
  HomePatientError({required this.error});
}

class GetDoctorListLoading extends HomePatientState {}

class GetDoctorListSuccess extends HomePatientState {}

class GetDoctorListError extends HomePatientState {
  final String error;
  GetDoctorListError({required this.error});
}

class HomePatientDoctorDataLoading extends HomePatientState {}

class HomePatientDoctorDataSuccess extends HomePatientState {}

class HomePatientDoctorDataError extends HomePatientState {
  final String error;
  HomePatientDoctorDataError({required this.error});
}

class SendMessageSucess extends HomePatientState {}

class SendMessageError extends HomePatientState {
  final String error;
  SendMessageError({required this.error});
}

class GetAllMessageSucess extends HomePatientState {}
