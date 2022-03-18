import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late DateTime createdDate;

  @HiveField(2)
  late bool isExpense = true;

  @HiveField(3)
  late double amount;

  @HiveField(4)
  late String description;
}
