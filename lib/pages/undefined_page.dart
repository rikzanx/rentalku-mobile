import 'package:flutter/material.dart';

class UndefinedPage extends StatelessWidget {
  final String name;

  const UndefinedPage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Route for $name is not defined'),
      ),
    );
  }
}
