/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';

const typeTheme = Typography.whiteMountainView;

class ThemeProvider {
  static const appColor = Color(0xFF1CAE81);
  static const secondaryAppColor = Color(0xFFFF8A44);
  static const appColorTint = Color(0xFFd2efe6);

  static const neutralAppColor1 = Color(0xFFFBA709);
  static const neutralAppColor2 = Color(0xFFFe2121);
  static const neutralAppColor3 = Color(0xFF1DBF73);

  static const whiteColor = Colors.white;
  static const blackColor = Color(0xFF000000);
  static const greyColor = Colors.grey;
  static const lightBlackColor = Colors.black12;
  static const starColor = Colors.yellow;

  static const backgroundColor = Color.fromARGB(255, 243, 243, 243);
  static const transParent = Colors.transparent;
  static const titleStyle = TextStyle(
      fontSize: 14, fontFamily: 'bold', color: ThemeProvider.whiteColor);
}

TextTheme txtTheme = Typography.whiteMountainView.copyWith(
  bodyLarge: typeTheme.bodyLarge?.copyWith(fontSize: 16),
  bodyMedium: typeTheme.bodyLarge?.copyWith(fontSize: 14),
  displayLarge: typeTheme.bodyLarge?.copyWith(fontSize: 32),
  displayMedium: typeTheme.bodyLarge?.copyWith(fontSize: 28),
  displaySmall: typeTheme.bodyLarge?.copyWith(fontSize: 24),
  headlineMedium: typeTheme.bodyLarge?.copyWith(fontSize: 21),
  headlineSmall: typeTheme.bodyLarge?.copyWith(fontSize: 18),
  titleLarge: typeTheme.bodyLarge?.copyWith(fontSize: 16),
  titleMedium: typeTheme.bodyLarge?.copyWith(fontSize: 24),
  titleSmall: typeTheme.bodyLarge?.copyWith(fontSize: 21),
);

ThemeData light = ThemeData(
    fontFamily: 'regular',
    primaryColor: ThemeProvider.appColor,
    secondaryHeaderColor: ThemeProvider.secondaryAppColor,
    disabledColor: const Color(0xFFBABFC4),
    brightness: Brightness.light,
    hintColor: const Color(0xFF9F9F9F),
    cardColor: ThemeProvider.appColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ThemeProvider.appColor)),
    textTheme: txtTheme,
    colorScheme: const ColorScheme.light(
            primary: ThemeProvider.appColor,
            secondary: ThemeProvider.secondaryAppColor)
        .copyWith(background: const Color(0xFFF3F3F3))
        .copyWith(error: const Color(0xFFE84D4F)));

ThemeData dark = ThemeData(
    fontFamily: 'regular',
    primaryColor: ThemeProvider.blackColor,
    secondaryHeaderColor: const Color(0xFF009f67),
    disabledColor: const Color(0xffa2a7ad),
    brightness: Brightness.dark,
    hintColor: const Color(0xFFbebebe),
    cardColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ThemeProvider.blackColor)),
    textTheme: txtTheme,
    colorScheme: const ColorScheme.dark(
            primary: ThemeProvider.blackColor, secondary: Color(0xFFffbd5c))
        .copyWith(background: const Color(0xFF343636))
        .copyWith(error: const Color(0xFFdd3135)));

heading1(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 22, fontFamily: 'bold', color: ThemeProvider.blackColor),
  );
}

heading2(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 18, fontFamily: 'medium', color: ThemeProvider.blackColor),
  );
}

heading3(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 16, fontFamily: 'medium', color: ThemeProvider.blackColor),
  );
}

heading4(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 14, fontFamily: 'medium', color: ThemeProvider.blackColor),
  );
}

subtitle1(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 16, color: ThemeProvider.blackColor),
  );
}

bodyText1(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: ThemeProvider.blackColor),
  );
}

lightText(val) {
  return Text(
    val,
    style: const TextStyle(
        fontSize: 14, fontFamily: 'medium', color: ThemeProvider.greyColor),
  );
}

smallText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 12, color: ThemeProvider.greyColor),
  );
}

smallBoldText(val) {
  return Text(
    val,
    style: const TextStyle(
        fontFamily: 'medium', fontSize: 12, color: ThemeProvider.blackColor),
  );
}

myBoxDecoration() {
  return BoxDecoration(
    color: ThemeProvider.whiteColor,
    borderRadius: const BorderRadius.all(
      Radius.circular(8),
    ),
    boxShadow: [
      BoxShadow(
          color: ThemeProvider.blackColor.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 3),
    ],
  );
}

textFieldDecoration() {
  return BoxDecoration(
    color: ThemeProvider.backgroundColor,
    borderRadius: const BorderRadius.all(
      Radius.circular(8.0),
    ),
    boxShadow: [
      BoxShadow(
          color: ThemeProvider.blackColor.withOpacity(0.2),
          offset: const Offset(0, 1),
          blurRadius: 3),
    ],
  );
}
