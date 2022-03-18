import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final TextEditingController descController;
  const Description({Key? key, required this.descController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Description',
      ),
      validator: (desc) => desc != null && desc.isEmpty ? 'Enter a desc' : null,
    );
  }
}
