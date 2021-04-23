import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserQR extends StatelessWidget {
  final String data;

  const UserQR(
    this.data, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QrImage(
      data: data,
      size: 200.0,
      version: QrVersions.auto,
    );
  }
}
