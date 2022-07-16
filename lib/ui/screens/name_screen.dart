import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vinote/consts.dart';
import 'package:vinote/main.dart';
import 'package:vinote/ui/screens/home_screen.dart';
import 'package:vinote/ui/values/styles.dart';
import 'package:vinote/ui/values/texts.dart';
import 'package:vinote/ui/values/widget.dart';

import '../values/colors.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  VoidCallback? onSubmitPressed;
  final nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nicknameController.addListener(onNicknameTyped);

    return Stack(
        children: [
          Background(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 64),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Center(child: h1("Welcome!", color: Colors.white))),
                  Expanded(
                    flex: 3,
                    child: UnconstrainedBox(
                      constrainedAxis: Axis.horizontal,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: nicknameBackgroundDecoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                h5("Type your nickname",
                                    color: Colors.white, align: TextAlign.center),
                                const SizedBox(height: 16),
                                TextField(
                                    controller: nicknameController,
                                    decoration: nicknameDecoration,
                                    textAlign: TextAlign.center,
                                    maxLength: 12,
                                    maxLines: 1),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  onPressed: onSubmitPressed,
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(color: purple),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
    );
  }

  onNicknameTyped() {
    if (nicknameController.text.isNotEmpty) {
      setState(() => onSubmitPressed = onSubmitPressedTask);
    } else {
      setState(() => onSubmitPressed = null);
    }
  }

  onSubmitPressedTask() {
    nickname = nicknameController.text;
    preferences.setString(nicknameKey, nicknameController.text);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen())
    );
  }
}
