import 'package:flutter/material.dart';
import 'package:hiveproject/model/expense.dart';
import 'package:hiveproject/pages/widgets/amount.dart';
import 'package:hiveproject/pages/widgets/description.dart';
import 'package:hiveproject/pages/widgets/name.dart';

class ExpenseDialog extends StatefulWidget {
  final Expense? expense;
  final Function(String name, double amount, bool isExpense, String description)
      onTap;

  const ExpenseDialog({
    Key? key,
    this.expense,
    required this.onTap,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<ExpenseDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isExpense = true;

  @override
  void initState() {
    super.initState();

    if (widget.expense != null) {
      final expense = widget.expense!;

      nameController.text = expense.name;
      amountController.text = expense.amount.toString();
      descriptionController.text = expense.description;
      isExpense = expense.isExpense;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expense != null;
    final title = isEditing ? 'Edit Expense' : 'Add Expense';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              Name(
                nameController: nameController,
              ),
              const SizedBox(height: 8),
              Amount(
                amountController: amountController,
              ),
              const SizedBox(height: 8),
              Description(
                descController: descriptionController,
              ),
              const SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: const Text('Expense'),
            value: true,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
          RadioListTile<bool>(
            title: const Text('Income'),
            value: false,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: const Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final amount = double.tryParse(amountController.text) ?? 0;
          final description = descriptionController.text;

          widget.onTap(name, amount, isExpense, description);

          Navigator.of(context).pop();
        }
      },
    );
  }
}
