import 'package:flutter/material.dart';
import 'package:flutter_rpg_tut/theme.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({super.key, required this.onPressed, required this.child});

  final Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryAccent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: child,
      ),
    );
  }
}
