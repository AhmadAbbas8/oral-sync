import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text('Un implemented tracking'),
          ),
        ),
        Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Text('data'),
            itemCount: 20,
          ),
        )
      ],
    );
  }
}
