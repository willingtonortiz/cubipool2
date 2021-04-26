import 'package:flutter/material.dart';

class NotificationDialog extends StatelessWidget {
  final String title;
  final VoidCallback onOk;
  final String? content;
  String? okText;

  NotificationDialog({
    Key? key,
    required this.title,
    required this.onOk,
    this.content,
    this.okText,
  }) : super(key: key) {
    okText ??= 'Aceptar';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content != null ? Text(content!) : null,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onOk();
          },
          child: Text(okText!),
        )
      ],
    );
  }
}
