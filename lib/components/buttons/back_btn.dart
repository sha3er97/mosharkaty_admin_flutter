import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: color,
        ),
      ),
    );
  }
}
