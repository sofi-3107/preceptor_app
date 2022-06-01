import 'package:flutter/material.dart';

var buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
);

var commonText = TextStyle(fontSize: 20);

var boxGradientDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        tileMode: TileMode.repeated,
        colors: [Colors.black, Colors.cyan]));

var greenGradientBox = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.green, Colors.black87]),
);
