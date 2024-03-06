import 'package:isar/isar.dart';

part 'expense.g.dart';

// this line is needed to generate the isar.g.dart file
// run the command `flutter pub run build_runner build` in the terminal
@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  final String name;
  final double amount;
  final DateTime date;

  Expense({
    required this.name,
    required this.amount,
    required this.date,
  });
}
