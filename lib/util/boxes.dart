import 'package:hive/hive.dart';
import 'package:hiveproject/model/expense.dart';
import 'package:hiveproject/model/profile.dart';

class Boxes {
  static Box<Expense> getTransactions() => Hive.box<Expense>('expenses');
  static Box<Profile> getProfile() => Hive.box<Profile>('profile');
}
