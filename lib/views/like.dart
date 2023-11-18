import 'package:flutter/material.dart';

class Like extends StatelessWidget {
  const Like({
    super.key,
    required this.liked,
    required this.onLikePressed
  });

  final VoidCallback onLikePressed;

  final bool liked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () { onLikePressed(); },
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border));
  }
}
