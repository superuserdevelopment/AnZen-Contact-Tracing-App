import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    String title, String message, BuildContext context) {
  return (showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 24.0, fontFamily: 'Circular'),
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }));
}
