import 'package:hive_flutter/hive_flutter.dart';

import '../models/expense_item.dart';

class HiveDatabase {
  // reference our box
  final _myBox = Hive.box('expense_database');

  // write data
  void saveData(List<ExpenseItem> allExpense) {    

    /*
    Hive can only store strings and dateTime, not custom objects like ExpenseItem.
    so lets convert ExpenseItem objects into types that can be stored in Hive.    
    */

    List<List<dynamic>> allExpensesFormatted = [];
    for (ExpenseItem expense in allExpense) {
      allExpensesFormatted.add([
        expense.name,
        expense.amount,
        expense.dateTime.toString(),
      ]);
    }
    // store in database
    _myBox.put('all_expenses', allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {

    /*
    Data is stored in Hive as a list of strings + dateTime, 
    so let's convert our saved data into ExpenseItem objects.    
    */

    List savedExpenses = _myBox.get('all_expenses', defaultValue: []);
    List<ExpenseItem> allExpenses = [];
    for (int i = 0; i < savedExpenses.length; i++) {
      allExpenses.add(
        ExpenseItem(
          name: savedExpenses[i][0],
          amount: savedExpenses[i][1],
          dateTime: DateTime.parse(savedExpenses[i][2]),
        ),
      );
    }
    return allExpenses;
  }
}
