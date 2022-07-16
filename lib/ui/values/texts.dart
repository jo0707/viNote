import 'package:flutter/material.dart';
import 'package:vinote/ui/values/colors.dart';

Text h1(String text,
        {Color color = textColor, TextAlign align = TextAlign.start}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: 48, overflow: TextOverflow.ellipsis),
      textAlign: align,
    );

Text h2(String text,
        {Color color = textColor, TextAlign align = TextAlign.start}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: 38, overflow: TextOverflow.ellipsis),
      textAlign: align,
    );

Text h3(String text,
        {Color color = textColor, TextAlign align = TextAlign.start}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: 30),
      textAlign: align,
    );

Text h4(String text,
        {Color color = textColor, TextAlign align = TextAlign.start}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: 24),
      textAlign: align,
    );

Text h5(String text,
        {Color color = textColor, TextAlign align = TextAlign.start}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: 20, overflow: TextOverflow.ellipsis),
      textAlign: align,
    );

Text h6(String text,
        {Color color = textColor, TextAlign align = TextAlign.start}) =>
    Text(
      text,
      style: TextStyle(color: color, fontSize: 16),
      textAlign: align,
    );
