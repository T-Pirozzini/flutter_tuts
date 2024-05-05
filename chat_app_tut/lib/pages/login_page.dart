import 'package:chat_app_tut/components/my_button.dart';
import 'package:chat_app_tut/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to go to the register page
  final void Function()? onTap;

  LoginPage({Key? key, required this.onTap}) : super(key: key);

  // login method
  void login() {}

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
            Text('Welcome back, you\'ve been missed!',
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

            const SizedBox(
              height: 20,
            ),

            // login button
            MyButton(
              buttonText: "Login",
              onTap: login,
            ),

            const SizedBox(
              height: 20,
            ),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member? ',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onTap,
                  child: const Text('Register now',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
