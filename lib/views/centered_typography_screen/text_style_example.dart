import 'package:flutter/material.dart';

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({Key? key, required this.name, required this.style})
      : super(key: key);

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name, style: style),
    );
  }
}
