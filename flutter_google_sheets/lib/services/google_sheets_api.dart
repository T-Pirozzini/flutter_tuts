import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "canvas-spark-383501",
  "private_key_id": "ba41c1d00bebe09f39b4ad2791e7025c7c15cfdd",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC7tg2qk6h0VSJb\npI0xCW9lrw0hvygYwHY6VYOPxiO7nJ3gCl1JZeaNjtm+09FhE2I78jsyHNPYK4VZ\nM0e5lGfIrccaz9k67t6dmYaKiXYvuqLdFWxuMUe/zJwAmUQ/AhAWbCJdf3HvqXfW\n+QbsVtOFRmfAB96wT7z+MldfDlXAkuHEwxz+r5ABHqaIZ2EJNPyLGwVTQKOgy+tk\nylNzCVjRSNoXNp8tQh8H3sUgfWXmbQ+zyxQdSWJsBoWJsq7DYqZNt0iig3/Urgqi\n8UxxE+wM5pB0dfJO5RwyCCuYXs1evwhW5EzPrzt01FrxX7ulUeQqSC1oRYsSQv/T\n4JwgjpqzAgMBAAECggEARqGWOt0cwclXCEy+o/j85bIcqtoW6FljI0gSHQNdZrbj\n4O2FdJzXR+S8okVpv7FfgVcAVzbpr6mQn6PgFUB2XNim1rvm7Xn8YijmqzJWOldr\n+OyaxEvex5jiCoehWmQYUZeWxr+xy5Bk+4rww/VX2gpH98X+UTFv1+ZxYd8u/Sqi\nRGNYJMToFWpvYb0p+TEsSJbpiyr6nZq1XLSz5uyUIN6fR2Kxof2Jfxv3cMvLJpdq\nIyvJipvESlIRly4a6M6Fu2ssoa/MwvcDjHfHhW31eN1jUKyR+/BubmrIpL0BxxWZ\nF9AydxftjA+/ywDjjDSDRhNhkFcbRQONaadc8sJf4QKBgQDsFtqV7zQxhcjoqfxl\nGYFapiH9eD1Vm+pbxhS8OKxEeCH2SgL5oQCFmMvGvf/sc6/vNub/AXQLIenUqbvr\nc4Ek00qA+lOWYo+/xFKLn2lTWrYk0Z6cU+3A3QwsIfvZBgu5us2qfO7YGQE8c0ND\nBm5Ra0lZG+vG39OmEdaYNzwTtwKBgQDLirhadjQFTdbVc/v90m+EOjs9kSKN62ml\n92J+USfax6mGbuDrOCLAdd563jNFL3ErrDWL7XppybFu9k6wzaT6VioXNZ2tidTP\nIZtD5mnUS9euIydeMmsPxNbicQ3ivTJe9LBVwk27TuWkAfH3Ara7XzY6HqqefcXn\njWtSfubI5QKBgQC4tkzA4Az67gw5lL1nMCRXkwGm+YsrTrh2oyyX8tM9IqyXsGJR\ngpkQ7XIJhaAVFJJC27axLybmitsSytW/KniRIkr5TGFXmLeVNvnKSaezUpaNif/J\nmZS7v3aFlPUhYCyOXMwKpoKMSkwASsIGT6LCSulxMXov9/D0zqISJ6z2UwKBgAqJ\nrwu37O+NXR8F9zjn6TAeV6zTU8enNXwLN8U0bGzOQ3+bQ/fJmzr9nzwbPupJD4Hk\nU41gCSNq9s244NAUhYMUbO9wri4q4aKrqb81Mat1FcCFP2eIErTpSvrEQaTIiNAT\nuQFnouCcsBTyqNVSBaXjwwn1Rn4YIuPfFXxa55XlAoGBAITrSUM29nnlqeWjiaTT\nffFfoIOUwU4k9aKWNnaoRsIFlsoO2MZCNGJuWEX5WN3REVgn02bM1Rnmf3B8AFc+\nYgQk1JPpW9GER3eAmcBwPnffW9nxSs60wkMYIYrsTsyhodmlUJm6FUW/X0h6AEi1\nElITnZzDKfY6lF7fL8OKxtTV\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-tutorial@canvas-spark-383501.iam.gserviceaccount.com",
  "client_id": "105739014059842885697",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-tutorial%40canvas-spark-383501.iam.gserviceaccount.com"
}
''';

// set up & connect to the spreadsheet
  static const _spreadsheetId = '1ZAeDl6i_CDeB8v880Vm_rke76ZrZj1cLrkIED1I91_c';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

// some variables to keep track of
  static int numberOfNotes = 0;
  static List<String> currentNotes = [];
  static bool loading = true;

// initialize the spreadsheet
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            '') {
      numberOfNotes++;
    }
    // now we know how many notes to load
    loadNotes();
  }

  // load existing notes from the spreadsheet
  static Future loadNotes() async {
    if (_worksheet == null) return;
    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (currentNotes.length < numberOfNotes) {
        currentNotes.add(newNote);
      }
    }
    loading = false;
  }

  // insert a new note
  static Future insert(String note) async {
    if (_worksheet == null) return;
    numberOfNotes++;
    currentNotes.add(note);
    await _worksheet!.values.appendRow([note]);
  }
}
