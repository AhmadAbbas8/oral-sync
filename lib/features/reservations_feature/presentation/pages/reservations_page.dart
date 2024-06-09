import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oralsync/core/service_locator/service_locator.dart';
import 'package:oralsync/features/reservations_feature/presentation/manager/reservations_cubit/reservations_cubit.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceLocator.instance<ReservationsCubit>(),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Un implemented tracking'),
            ),
          ),
          const Divider(
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemBuilder: (context, index) => Text('data'),
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
