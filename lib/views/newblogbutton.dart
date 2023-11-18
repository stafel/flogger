import 'package:flutter/material.dart';

class NewBlogButton extends StatelessWidget {
  const NewBlogButton({
    super.key,
    required this.text,
    required this.onPressed
  });

  final VoidCallback onPressed;

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () { onPressed(); },
        child: Text(text),
        );
  }
}
