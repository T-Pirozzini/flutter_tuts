import 'package:expense_tracker_tut/components/my_list_tile.dart';
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

  // open edit box
  void openEditBox(Expense expense) {
    // pre-fill existing values into textfields
    String existingName = expense.name;
    String existingAmount = expense.amount.toString();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text('Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // user input -> expense name
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: existingName),
              ),

              // user input -> expense amount
              TextField(
                controller: amountController,
                decoration: InputDecoration(hintText: existingAmount),
              ),
            ],
          ),
          actions:
              // cancel button
              [
            _cancelButton(),
            // save button
            _editExpenseButton(expense),
          ]),
    );
  }

  // open delete box
  void openDeleteBox(Expense expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Expense'),        
        actions: [
          // cancel button
          _cancelButton(),
          // delete button
          _deleteExpenseButton(expense),
        ],
      ),
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
            return MyListTile(
              title: individualExpense.name,
              trailing: formatAmount(individualExpense.amount),
              onEditPressed: (context) => openEditBox(individualExpense),
              onDeletePressed: (context) => openDeleteBox,
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

  // save button --> Edit expense
  Widget _editExpenseButton(Expense expense) {
    return MaterialButton(
        onPressed: () async {
          // save as long as at least one textfield has been changed
          if (nameController.text.isEmpty || amountController.text.isNotEmpty) {
            // pop box
            Navigator.pop(context);

            // create a new updated expense
            Expense updatedExpense = Expense(
                name: nameController.text.isNotEmpty
                    ? nameController.text
                    : expense.name,
                amount: convertStringToDouble(amountController.text),
                date: DateTime.now());

            // old expense id
            int existingId = expense.id;

            // save to db
            await context
                .read<ExpenseDatabase>()
                .updateExpense(existingId, updatedExpense);
          }
        },
        child: const Text('Save'));
  }
}
