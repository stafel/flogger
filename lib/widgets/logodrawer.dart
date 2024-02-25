import 'package:flutter/material.dart';
import 'package:frogger/widgets/navbackbutton.dart';

class LogoDrawer extends StatelessWidget {
  const LogoDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) => 
      Row(
        children: [ 
          const NavBackButton(),
          IconButton( 
            icon: Image.asset("images/logo.png"),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ]
    ),
    );
  }
}