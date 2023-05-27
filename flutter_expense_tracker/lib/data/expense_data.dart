import '../datetime/date_time_helper.dart';
import '../models/expense_item.dart';

class ExpenseData {
  // list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  // get expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // add new expense
  void addNewExpense(ExpenseItem expenseToAdd) {
    overallExpenseList.add(expenseToAdd);
  }

  // delete expense
  void deleteExpense(ExpenseItem expenseToDelete) {
    overallExpenseList.remove(expenseToDelete);
  }

  // get weekday (mon, tues, wed, etc.) from a dateTimeobject
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tues';
      case 3:
        return 'Wed';
      case 4:
        return 'Thurs';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get date for the start of the week
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get todays date
    DateTime today = DateTime.now();

    // go backwards from today to find Sunday
    for (int i = 0; i < 7; i++) {
      if (today.weekday == DateTime.sunday) {
        startOfWeek = today;
        break;
      } else {
        today = today.subtract(const Duration(days: 1));
      }
    }
    return startOfWeek!;
  }

  /*
  convert overall list of expenses into a daily expense summary
  e.g.

  overallExpenseList = 
  [
    [food, 2023/01/30], $10],
    [hat, 2023/01/30], $15],
    [drinks, 2023/01/31], $1],
    [food, 2023/01/30], $10],
    [food, 2023/01/30], $10],
    [food, 2023/01/30], $10],
    [food, 2023/01/30], $10],

  ]

  DailyExpenseSummary = 
  [
    [2023/01/30, $55],
    [2023/01/31, $1],
  ]
  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amountTotalForDay
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary[date] = amount;
      }
    }
    return dailyExpenseSummary;
  }
}
