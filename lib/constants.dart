import 'package:flutter/material.dart';

class Constant {
  static Color grey = const Color.fromRGBO(55, 60, 80, 1);
  static Color alert = const Color(0xffF41F6C);
  static Color lightBlue = const Color(0xff6C5DD2).withOpacity(.2);
  static Color veryDarkBlue = const Color(0xff02062A).withOpacity(.2);
  static Color disabledColor = const Color(0xff1D243F).withOpacity(.97);

  static LinearGradient whiteLinearGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [const Color(0xffE4E4E4).withOpacity(.2), Colors.transparent]);
  static LinearGradient redGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xffF41F6C),
        Color(0xffF41F6C),
      ]);

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: 'Helvetica',
    fontSize: 12.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle hintStyle = TextStyle(
    fontFamily: 'Helvetica',
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
}
