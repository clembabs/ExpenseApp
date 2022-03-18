import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  final TextEditingController nameController;
  const Name({Key? key, required this.nameController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Name',
      ),
      validator: (name) => name != null && name.isEmpty ? 'Enter a name' : null,
    );
  }
}
