import 'package:flutter/material.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
