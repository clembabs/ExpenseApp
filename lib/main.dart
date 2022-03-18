import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hiveproject/model/expense.dart';
import 'package:hiveproject/model/profile.dart';
import 'package:hiveproject/pages/expense_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expenses');
  await Hive.openBox<Profile>('profile');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Expense App';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: const ExpensePage(),
      );
}
