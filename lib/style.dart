import 'package:flutter/material.dart';

InputDecoration textFieldDecoration(imageName, hintText) {
  return InputDecoration(
    prefixIcon: Image.asset('assets/icons/'+ imageName, scale: 20,),
    hintText: hintText,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
  );
}

elevatedButtonStyle() {
  return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      onPrimary: Colors.white);
}
