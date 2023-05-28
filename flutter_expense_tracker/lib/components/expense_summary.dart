import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/bar%20graph/bar_graph.dart';
import 'package:flutter_expense_tracker/datetime/date_time_helper.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfTheWeek;
  const ExpenseSummary({super.key, required this.startOfTheWeek});

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of the week
    String sunday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfTheWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
          monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
          tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
          wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
          thuAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
          friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
          satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,
        ),
      ),
    );
  }
}
