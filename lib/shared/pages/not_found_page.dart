import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class NotFoundPage extends StatelessWidget {
  final String message;
  final String? imageUrl;

  const NotFoundPage({
    Key? key,
    required this.message,
    this.imageUrl,
  }) : super(key: key);

  const NotFoundPage.fromMonitaChina(this.message, {Key? key})
      : imageUrl =
            'https://i.pinimg.com/originals/b0/0b/a9/b00ba99ad82a972d4e5a481385d8e52e.png',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 2 / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMessage(context, message),
                _buildImageFromUrl(context, imageUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.headline5?.fontSize,
      ),
    );
  }

  Widget _buildImageFromUrl(BuildContext context, String? imageUrl) {
    return Conditional.single(
      context: context,
      conditionBuilder: (context) => imageUrl != null,
      widgetBuilder: (context) => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Image.network(
          imageUrl!,
          width: 160.0,
        ),
      ),
      fallbackBuilder: (context) => Container(),
    );
  }
}
