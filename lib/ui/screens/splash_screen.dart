import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vinote/main.dart';
import 'package:vinote/ui/screens/home_screen.dart';
import 'package:vinote/ui/screens/name_screen.dart';

import '../../consts.dart';
import '../values/widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          const Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: const Text(
                    appName,
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                    ),
                  ),
                )
            ),
          ),
        ]
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _opacity = 1));
    var nextScreen = nickname == null ? const NameScreen() : const HomeScreen();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => nextScreen)
      );
    });
  }
}
