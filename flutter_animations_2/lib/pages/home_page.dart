import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // controller
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  bool bookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_HBXF2O.json'),
            GestureDetector(
              onTap: () {
                if (!bookmarked) {
                  bookmarked = true;
                  _controller.forward();
                } else {
                  bookmarked = false;
                  _controller.reverse();
                }
              },
              child: Lottie.network(
                'https://assets5.lottiefiles.com/packages/lf20_xdfeea13.json',
                controller: _controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
