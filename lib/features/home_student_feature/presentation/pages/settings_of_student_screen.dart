import "package:flutter/material.dart";

class SettingsOfStudentScreen extends StatelessWidget {
  static const String routeName = "/SettingsOfStudentScreen";
  const SettingsOfStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Container(
        height: size.height * 50,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
        ),
        child: ListTile(
          leading: const Icon(Icons.language),
          title: const Text(
            'Language',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Switch.adaptive(
            value: false,
            onChanged: (value) {
              value = !value;
            },
          ),
        ),
      ),
    );
  }
}
