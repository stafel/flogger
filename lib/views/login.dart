
import 'package:flutter/material.dart';
import 'package:frogger/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key});
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.enterUsername;
        }
        return null;
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.enterPassword;
        }
        return null;
      },
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() {
    return LoginViewState();
  }

}

class LoginViewState extends State<LoginView> {
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(child: Form(key: _formKey, child: Form( 
      child: Column(
      children: [
        Text(AppLocalizations.of(context)!.username),
        const UsernameField(),
        Text(AppLocalizations.of(context)!.password),
        const PasswordField(),
        ElevatedButton(onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.login)),
            );
          }
        },
        child: Text(AppLocalizations.of(context)!.login),
        )
      ],
    ))));
  }
}