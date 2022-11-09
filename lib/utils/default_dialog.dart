import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

Future showDefaultDialog(
  BuildContext context, {
  String? title,
  required String message,
  String textAccept = "Aceptar",
  String? textAction,
  VoidCallback? onAction,
  VoidCallback? onCancel,
  Color? cancelColor,
}) async {
  if (message.isNotEmpty) {
    if (Platform.isIOS) {
      return await showAppleDialog(
        context,
        title: title,
        message: message,
        textCancel: textAccept,
        textConfirm: textAction,
        onConfirm: onAction,
        onCancel: onCancel,
        cancelColor: cancelColor,
      );
    } else {
      return await showMaterialDialog(
        context,
        title: title,
        message: message,
        textCancel: textAccept,
        textConfirm: textAction,
        onConfirm: onAction,
        onCancel: onCancel,
        cancelColor: cancelColor,
      );
    }
  }
}

Future showMaterialDialog(
  BuildContext ctx, {
  String? title,
  required String message,
  String textCancel = "Aceptar",
  String? textConfirm,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Color? cancelColor,
}) async {
  final resultMaterial = await showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
        title: title != null ? Text(title) : null,
        actions: [
          TextButton(
            style: ButtonStyle(
              overlayColor: cancelColor != null
                  ? MaterialStateProperty.all(cancelColor)
                  : null,
            ),
            onPressed: () {
              (onCancel != null) ? onCancel() : Navigator.of(context).pop();
            },
            child: Text(
              textCancel,
              style: TextStyle(color: cancelColor),
            ),
          ),
          if (textConfirm != null)
            TextButton(
              onPressed: () {
                (onConfirm != null) ? onConfirm() : Navigator.of(context).pop();
              },
              child: Text(textConfirm),
            )
        ],
      );
    },
  );
  return resultMaterial;
}

Future showAppleDialog(
  BuildContext ctx, {
  String? title,
  required String message,
  String textCancel = "Aceptar",
  String? textConfirm,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Color? cancelColor,
}) async {
  final resultCupertino = await showCupertinoDialog(
    context: ctx,
    builder: (BuildContext context) => CupertinoAlertDialog(
      content: Text(message),
      title: title != null ? Text(title) : null,
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            (onCancel != null) ? onCancel() : Navigator.of(context).pop();
          },
          child: Text(
            textCancel,
            style: TextStyle(color: cancelColor),
          ),
        ),
        if (textConfirm != null)
          CupertinoDialogAction(
            onPressed: () {
              (onConfirm != null) ? onConfirm() : Navigator.of(context).pop();
            },
            child: Text(textConfirm),
          )
      ],
    ),
  );
  return resultCupertino;
}
