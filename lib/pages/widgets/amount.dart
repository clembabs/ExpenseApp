import 'package:flutter/material.dart';

class Amount extends StatelessWidget {
  final TextEditingController amountController;
  const Amount({Key? key, required this.amountController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter Amount',
      ),
      keyboardType: TextInputType.number,
      validator: (amount) => amount != null && double.tryParse(amount) == null
          ? 'Enter a valid number'
          : null,
      controller: amountController,
    );
  }
}
