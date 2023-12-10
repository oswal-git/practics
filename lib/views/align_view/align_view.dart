import 'package:flutter/material.dart';

class AlignView extends StatefulWidget {
  const AlignView({super.key});

  @override
  State<AlignView> createState() => _AlignViewState();
}

class _AlignViewState extends State<AlignView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios')),
      extendBody: true,
      body: Container(
        margin: const EdgeInsets.all(20),
        color: Colors.teal,
        width: 500,
        height: 500,
        child: Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Icon(
              Icons.people_alt_rounded,
              size: 40,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
