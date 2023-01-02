import 'package:flutter/material.dart';

OutlineInputBorder getInputBorder(bool noError,
    {Color outlineColor = Colors.black,
    double thickness = 1.0,
    double radius = 10}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: noError ? outlineColor : Colors.red, width: thickness),
    borderRadius: BorderRadius.circular(radius),
  );
}

Size getWidgetSize(GlobalKey globalKey) {
  RenderBox renderBox =
      globalKey.currentContext?.findRenderObject() as RenderBox;

  return renderBox.size;
}
