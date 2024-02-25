import 'package:flutter/material.dart';
import 'package:frogger/widgets/logodrawer.dart';
import 'package:frogger/widgets/customdrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Contains general scaffold data to be reused in pages
class ReusableScaffold extends StatelessWidget {
  final Widget child;
  final bool showIcon;
  final bool showDrawer;
  final String? title;

  const ReusableScaffold({super.key, required this.child, this.showIcon=false, this.showDrawer=false, this.title});

  @override
  Widget build(BuildContext context) {

    String titleText = AppLocalizations.of(context)!.title;
    if (title != null) {
      titleText = title!;
    }

    return Scaffold(
        drawer: showDrawer ? const CustomDrawer() : null,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(titleText),
          leading: showIcon ? const LogoDrawer() : null,
          actions: [LoginIconButton()]
        ),
        body: child
    );
  }
}


