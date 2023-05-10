/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final String text;
  final Color colors;

  const MyTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.colors,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 6),
        ),
        onPressed: onPressed,
        child: Text(text,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: colors,
              fontFamily: 'medium',
              fontSize: 14,
            )),
      ),
    );
  }
}
