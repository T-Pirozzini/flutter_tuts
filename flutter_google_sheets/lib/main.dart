import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

const _spreadsheetId = '1ZAeDl6i_CDeB8v880Vm_rke76ZrZj1cLrkIED1I91_c';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load credentials from json file
  final jsonStr =
      await rootBundle.loadString('assets/gsheets_credential.json');
  final credentials = jsonDecode(jsonStr);

  // init gsheets
  final gsheets = GSheets(credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = ss.worksheetByTitle('Worksheet1');

  // updating a cell
  await sheet!.values.insertValue('Travis', column: 1, row: 1);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
