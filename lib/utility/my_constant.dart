import 'package:flutter/material.dart';

class MyConstant {
  // for Route
  static String routeAuthen = '/authen';
  static String routeOfficer = '/officerService';
  static String routeAdmin = '/adminService';
  static String routeShowCart = '/showCart';

  // for General
  static String appName = 'Ung Store';
  static String domain = 'https://www.androidthai.in.th/bigc';

  // for Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';

  // for Color
  static Color primary = Color(0xff699937);
  static Color dark = Color(0xff3a6b02);
  static Color light = Color(0xff9aca65);

  // for Style
  TextStyle h1Style() => TextStyle(
        color: dark,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        color: dark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        color: dark,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(primary: primary);
}
