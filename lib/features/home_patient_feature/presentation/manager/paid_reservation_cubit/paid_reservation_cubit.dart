import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'paid_reservation_state.dart';

class PaidReservationCubit extends Cubit<PaidReservationState> {
  PaidReservationCubit() : super(PaidReservationInitial());
}
