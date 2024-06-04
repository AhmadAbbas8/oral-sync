part of 'doctor_cubit.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();
}

final class DoctorInitial extends DoctorState {
  @override
  List<Object> get props => [];
}
