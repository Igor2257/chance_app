import 'package:flutter/material.dart';

class AddWard extends StatefulWidget {
  const AddWard({super.key});

  @override
  State<AddWard> createState() => _AddWardState();
}

class _AddWardState extends State<AddWard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Додати підопічного"),
      ),

    );
  }
}
