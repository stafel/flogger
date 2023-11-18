import 'package:flutter/material.dart';

class Like extends StatelessWidget {
  const Like({
    super.key,
    required this.liked,
  });

  final bool liked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border));
  }
}
