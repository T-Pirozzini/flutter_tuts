import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final text;
  final function;

  const MyButton({super.key, this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.pink,
            child: Text(text, style: const TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}
