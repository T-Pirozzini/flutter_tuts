import 'package:chat_app_tut/components/my_button.dart';
import 'package:chat_app_tut/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // go to the login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(Icons.login,
                size: 100, color: Theme.of(context).colorScheme.primary),

            const SizedBox(height: 20),

            // welcome back message
            Text("Let's create an account for you!",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),

            const SizedBox(
              height: 20,
            ),

            // email textfield
            MyTextField(
                hintText: "Email",
                obscuretext: false,
                controller: _emailController),

            const SizedBox(height: 10),

            // pw textfield
            MyTextField(
                hintText: "Password",
                obscuretext: true,
                controller: _pwController),

            const SizedBox(height: 10),

            // confirm pw textfield
            MyTextField(
                hintText: "Confirm password",
                obscuretext: true,
                controller: _confirmPwController),

            const SizedBox(
              height: 20,
            ),

            // login button
            MyButton(
              buttonText: "Register",
              onTap: register,
            ),

            const SizedBox(
              height: 20,
            ),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already a member? ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onTap,
                  child: const Text('Login now',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
