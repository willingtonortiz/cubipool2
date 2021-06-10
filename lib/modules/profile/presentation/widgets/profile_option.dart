import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  const ProfileOption({
    Key? key,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final Function onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.crop_square),
            SizedBox(width: 10),
            Text(title, style: TextStyle(fontSize: 16)),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
