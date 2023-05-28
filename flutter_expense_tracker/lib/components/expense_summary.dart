import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/bar%20graph/bar_graph.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfTheWeek;
  const ExpenseSummary({super.key, required this.startOfTheWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => const SizedBox(
        height: 200,
        child: MyBarGraph(
          maxY: 100,
          sunAmount: 20,
          monAmount: 30,
          tueAmount: 70,
          wedAmount: 50,
          thuAmount: 80,
          friAmount: 90,
          satAmount: 10,
        ),
      ),
    );
  }
}
