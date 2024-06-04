part of 'doctor_cubit.dart';

sealed class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => [];
}

final class DoctorInitial extends DoctorState {}
final class BottomNavBarChanged extends DoctorState {
  final int index;

  const BottomNavBarChanged({required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [index];
}
