import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

class AsyncConfirmationDialog extends StatefulWidget {
  final String title;
  final Future<void> Function() onOk;
  final Future<void> Function()? onCancel;
  final String? content;
  final String? okText;
  final String? cancelText;

  AsyncConfirmationDialog({
    Key? key,
    required this.title,
    required this.onOk,
    this.onCancel,
    this.content,
    this.okText = 'Aceptar',
    this.cancelText = 'Cancelar',
  }) : super(key: key);

  @override
  _AsyncConfirmationDialogState createState() =>
      _AsyncConfirmationDialogState();
}

class _AsyncConfirmationDialogState extends State<AsyncConfirmationDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.content != null) Text(widget.content!),
            _buildLoader(),
          ],
        ),
      ),
      actions: [
        _buildOkButton(),
        _buildCancelButton(),
      ],
    );
  }

  Widget _buildLoader() {
    return Conditional.single(
      context: context,
      conditionBuilder: (ctx) => _isLoading,
      widgetBuilder: (ctx) => Column(
        children: [
          const SizedBox(height: 16.0),
          CircularProgressIndicator(),
        ],
      ),
      fallbackBuilder: (ctx) => Container(),
    );
  }

  Widget _buildOkButton() {
    return TextButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              await widget.onOk();
              Navigator.of(context).pop();
            },
      child: Text(widget.okText!),
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              if (widget.onCancel != null) {
                await widget.onCancel!();
              }
              Navigator.of(context).pop();
            },
      child: Text(widget.cancelText!),
    );
  }
}
