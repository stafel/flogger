import 'package:flutter/material.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// shows login/logout button depending on api status
class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogApi>(builder: (ctx, api, _) {

      var appCtx = AppLocalizations.of(context)!;

      if (api.status == BlogApiStatus.conError) {
        return Text(appCtx.error);
      }

      if (api.status == BlogApiStatus.conAnonym) {
        return TextButton(
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));}, 
          child: Text(appCtx.login)
          );
      }

      if (api.status == BlogApiStatus.conLogin) {
        return TextButton(
          onPressed: () { print("logout"); }, 
          child: Text(appCtx.logout)
          );
      }

      return Text(appCtx.connecting);
    });
  }

}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [ListTile(title: Text(AppLocalizations.of(context)!.account),), LoginButton()],
      ),
    );
  }
}
