import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {required this.text,
      required this.visible,
      required this.onPressed,
      super.key});

  final String text;
  final bool visible;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: visible ? null : onPressed,
        child: visible
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(
                text,
              ));
  }
}
