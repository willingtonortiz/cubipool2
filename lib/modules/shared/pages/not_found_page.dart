import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class NotFoundPage extends StatelessWidget {
  final String message;
  final String? imageUrl;

  NotFoundPage({
    Key? key,
    required this.message,
    this.imageUrl,
  }) : super(key: key);

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
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                  ),
                ),
                _buildImage(context, imageUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, String? imageUrl) {
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
