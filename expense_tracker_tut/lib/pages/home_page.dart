import 'package:expense_tracker_tut/database/expense_database.dart';
import 'package:expense_tracker_tut/helper/helper_functions.dart';
import 'package:expense_tracker_tut/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    Provider.of<ExpenseDatabase>(context, listen: false).readExpenses();
    super.initState();
  }

  // open new expense box
  void openNewExpenseBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('New Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // user input -> expense name
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),

              // user input -> expense amount
              TextField(
                controller: amountController,
                decoration: const InputDecoration(hintText: "Amount"),
              ),
            ],
          ),
          actions:
              // cancel button
              [
            _cancelButton(),
            // save button
            _createNewExpenseButton(),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseDatabase>(
      builder: (context, value, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: openNewExpenseBox,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: value.allExpenses.length,
          itemBuilder: (context, index) {
            // get inividual expense
            Expense individualExpense = value.allExpenses[index];

            // return list tile UI
            return ListTile(
              title: Text(individualExpense.name),
              trailing: Text(
                formatAmount(individualExpense.amount),
              ),
            );
          },
        ),
      ),
    );
  }

  // cancel button
  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () {
        // pop box
        Navigator.pop(context);

        // clear controllers
        nameController.clear();
        amountController.clear();
      },
      child: const Text('Cancel'),
    );
  }

  // save button
  Widget _createNewExpenseButton() {
    return MaterialButton(
        onPressed: () async {
          // only save if there is something in the textfield to save
          if (nameController.text.isNotEmpty &&
              amountController.text.isNotEmpty) {
            // pop the box
            Navigator.pop(context);
            // create new expense
            Expense newExpense = Expense(
                name: nameController.text,
                amount: convertStringToDouble(amountController.text),
                date: DateTime.now());

            // save to db
            await context.read<ExpenseDatabase>().createNewExpense(newExpense);

            // clear controllers
            nameController.clear();
            amountController.clear();
          }
        },
        child: const Text('Save'));
  }
}
