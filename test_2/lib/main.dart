import 'package:flutter/material.dart';

void main() {
  List<int> scores = [50, 75, 20, 99, 100, 30];

  for (int i = 0; i < scores.length; i += 8) {
    print('The current value of i is $i');
  }
}
