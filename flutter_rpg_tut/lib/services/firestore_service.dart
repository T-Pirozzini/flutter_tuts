import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final ref = FirebaseFirestore.instance.collection('characters');
}
