import 'package:expense_tracker_tut/database/expense_database.dart';
import 'package:expense_tracker_tut/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // intialize db
  await ExpenseDatabase.initialize();

  runApp(ChangeNotifierProvider(
      create: (context) => ExpenseDatabase(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
