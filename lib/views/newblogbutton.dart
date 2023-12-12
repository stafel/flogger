import 'package:flutter/material.dart';
import 'package:frogger/views/blogdetailpage.dart';

class NewBlogButton extends StatelessWidget {
  const NewBlogButton({super.key, required this.text, required this.onPressed});

  final VoidCallback onPressed;

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
