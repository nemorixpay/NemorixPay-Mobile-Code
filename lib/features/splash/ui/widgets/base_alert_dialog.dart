import 'package:flutter/material.dart';

/// @file        base_alert_dialog.dart
/// @brief       Implementation of basic behavior for alert dialogs.
/// @details
/// @author      Miguel Fagundez
/// @date        04/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class BaseAlertDialog extends StatelessWidget {
  late final String _title;
  late final String _content;
  late final String? _yes;
  late final String? _no;
  late final Function _yesOnPressed;
  late final Function _noOnPressed;

  BaseAlertDialog({
    super.key,
    required String title,
    required String content,
    required Function yesOnPressed,
    required Function noOnPressed,
    String yes = "Yes",
    String no = "No",
  }) {
    _title = title;
    _content = content;
    _yesOnPressed = yesOnPressed;
    _noOnPressed = noOnPressed;
    _yes = yes;
    _no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_title),
      content: Text(_content),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
          child: Text(_yes ?? ''),
          onPressed: () {
            _yesOnPressed();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(_no ?? ''),
          onPressed: () {
            _noOnPressed();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
