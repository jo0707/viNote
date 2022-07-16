import 'package:flutter/material.dart';
import 'package:vinote/ui/values/widget.dart';

const nicknameDecoration = InputDecoration(
  border: nicknameBorder,
  enabledBorder: nicknameBorder,
  focusedBorder: nicknameBorder,
  filled: true,
  fillColor: Colors.white,
  isDense: true,
);

final nicknameBackgroundDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.3),
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    border: Border.all(
      color: Colors.white.withOpacity(0.3),
    ),
    boxShadow: [defaultShadow()]
);

const nicknameBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: Colors.white));
