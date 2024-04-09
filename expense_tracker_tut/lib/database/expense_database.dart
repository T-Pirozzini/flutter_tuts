import 'package:expense_tracker_tut/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class ExpenseDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Expense> _allExpenses = [];

  /*
  setup
  */
  // initialize setup
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([ExpenseSchema], directory: dir.path);
  }

/*
  getters
  */
  List<Expense> get allExpenses => _allExpenses;

/*
  operations
  */
  //create
  Future<void> createNewExpense(Expense newExpense) async {
    // add to db
    await isar.writeTxn(() => isar.expenses.put(newExpense));
    // re-read from db
    await readExpenses();
  }

  //read
  Future<void> readExpenses() async {
    // fetch all existing expenses from db
    List<Expense> fetchedExpenses = await isar.expenses.where().findAll();
    // give to local expense list
    _allExpenses.clear();
    _allExpenses.addAll(fetchedExpenses);

    // update UI
    notifyListeners();
  }

  //update
  Future<void> updateExpense(int id, Expense updatedExpense) async {
    // make sure new expense has same id as existing one
    updatedExpense.id = id;
    // update in db
    await isar.writeTxn(() => isar.expenses.put(updatedExpense));
    // re-read from db
    await readExpenses();
  }

  //delete
  Future<void> deleteExpense(int id) async {
    // delete from db
    await isar.writeTxn(() => isar.expenses.delete(id));
    // re-read from db
    await readExpenses();
  }
/*
  helper methods

  */

  // calculate total expenses for each month
  Future<Map<int, double>> calculateMonthlyTotals() async {
    // ensure the expenses are read from the db
    await readExpenses();

    // create a map to keep track of total expenses per month
    Map<int, double> monthlyTotals = {};

    // iterate over all expenses
    for (var expense in _allExpenses) {
      // extract the month from the date of the expense
      int month = expense.date.month;

      // if the month is not in the map, initialize 0
      if (!monthlyTotals.containsKey(month)) {
        monthlyTotals[month] = 0;
      }

      // add the expesnse amount to the total for the month
      monthlyTotals[month] = monthlyTotals[month]! + expense.amount;
    }
    return monthlyTotals;
  }

  // get start month
  int getStartMonth() {
    if (_allExpenses.isEmpty) {
      return DateTime.now().month;
    }

    // sort expenses by date to find the earliest
    _allExpenses.sort((a, b) => a.date.compareTo(b.date));

    return _allExpenses.first.date.month;
  }

  // get start year
  int getStartYear() {
    if (_allExpenses.isEmpty) {
      return DateTime.now().year;
    }

    // sort expenses by date to find the earliest
    _allExpenses.sort((a, b) => a.date.compareTo(b.date));

    return _allExpenses.first.date.year;
  }
}
