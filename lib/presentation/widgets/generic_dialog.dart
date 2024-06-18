import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      if (Platform.isIOS) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              letterSpacing: 0,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(letterSpacing: 0, fontSize: 14),
          ),
          actions: options.keys.map((optionTitle) {
            final value = options[optionTitle];
            return CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.black),
              child: Text(optionTitle),
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        );
      }
      return AlertDialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        actionsPadding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        title: Text(
          title,
          style: const TextStyle(
            letterSpacing: 0,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(letterSpacing: 0, fontSize: 14),
        ),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}