import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hiveproject/model/expense.dart';
import 'package:hiveproject/util/boxes.dart';
import 'package:intl/intl.dart';

import 'widgets/expense_dialog.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({Key? key}) : super(key: key);

  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<Expense>>(
          valueListenable: Boxes.getTransactions().listenable(),
          builder: (context, box, _) {
            final expenses = box.values.toList().cast<Expense>();

            return buildContent(expenses);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => ExpenseDialog(
              onTap: addExpense,
            ),
          ),
        ),
      );

  Widget buildContent(List<Expense> expenses) {
    if (expenses.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      final netExpense = expenses.fold<double>(
        0,
        (previousValue, expense) => expense.isExpense
            ? previousValue - expense.amount
            : previousValue + expense.amount,
      );
      final newExpenseString = 'N${netExpense.toStringAsFixed(2)}';
      final color = netExpense > 0 ? Colors.green : Colors.red;

      return Column(
        children: [
          const SizedBox(height: 24),
          Text(
            'Net Expense: $newExpenseString',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: color,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: expenses.length,
              itemBuilder: (BuildContext context, int index) {
                final expense = expenses[index];

                return buildExpense(context, expense);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildExpense(
    BuildContext context,
    Expense expense,
  ) {
    final color = expense.isExpense ? Colors.red : Colors.green;
    final date = DateFormat.yMMMd().format(expense.createdDate);
    final amount = 'N' + expense.amount.toStringAsFixed(2);
    final description = expense.description;

    return Card(
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          expense.name,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date),
            const SizedBox(
              height: 5,
            ),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        trailing: Text(
          amount,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          buildButtons(context, expense),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context, Expense expense) => Row(
        children: [
          Expanded(
            child: TextButton.icon(
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ExpenseDialog(
                    expense: expense,
                    onTap: (name, amount, isExpense, description) =>
                        editTransaction(
                            expense, name, amount, isExpense, description),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton.icon(
              label: const Text('Delete'),
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTransaction(expense),
            ),
          )
        ],
      );

  Future addExpense(
    String name,
    double amount,
    bool isExpense,
    description,
  ) async {
    final expense = Expense()
      ..name = name
      ..createdDate = DateTime.now()
      ..amount = amount
      ..isExpense = isExpense
      ..description = description;

    final box = Boxes.getTransactions();
    box.add(expense);
    //box.put('mykey', expense);

    // final mybox = Boxes.getTransactions();
    // final myTransaction = mybox.get('key');
    // mybox.values;
    // mybox.keys;
  }

  void editTransaction(
    Expense expense,
    String name,
    double amount,
    bool isExpense,
    String description,
  ) {
    expense.name = name;
    expense.amount = amount;
    expense.isExpense = isExpense;
    expense.description = description;

    // final box = Boxes.getTransactions();
    // box.put(expense.key, expense);

    expense.save();
  }

  void deleteTransaction(Expense expense) {
    // final box = Boxes.getTransactions();
    // box.delete(expense.key);

    expense.delete();
    //setState(() => expenses.remove(expense));
  }
}
