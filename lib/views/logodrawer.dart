import 'package:flutter/material.dart';

class LogoDrawer extends StatelessWidget {
  const LogoDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => IconButton( 
      icon: Image.asset("images/logo.png"),
      onPressed: () => Scaffold.of(context).openDrawer(),
    ),
    );
  }
}