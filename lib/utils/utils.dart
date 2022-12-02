import 'dart:core';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String urlHttpsConvert(String imageUrl) {
    String firstPartUrl = '';
    String secondPartUrl = '';
    String fullUrl = '';

    for (int i = 0; i < 4; i++) {
      firstPartUrl = firstPartUrl + imageUrl[i];
    }

    for (int i = 4; i < imageUrl.length; i++) {
      secondPartUrl = secondPartUrl + imageUrl[i];
    }

    fullUrl = firstPartUrl + 's' + secondPartUrl;

    return fullUrl;
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.black,
        textColor: Color.fromARGB(255, 90, 82, 82),
        fontSize: 30,
        toastLength: Toast.LENGTH_LONG);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        borderRadius: BorderRadius.circular(8),
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 20,
          color: Colors.white,
        ),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }

  static snakBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
