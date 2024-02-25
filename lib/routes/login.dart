import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/widgets/reusablescaffold.dart';
import 'package:provider/provider.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true, // focus this field as soon as it is visible
      //autovalidateMode: AutovalidateMode.onUserInteraction,
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
  final TextEditingController controller;

  const PasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      //autovalidateMode: AutovalidateMode.onUserInteraction,
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

class LoginError extends StatelessWidget {
  final bool hasError;
  const LoginError({super.key, required this.hasError});

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return Text(AppLocalizations.of(context)!.loginError);
    }
    return const Text("");
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
  final _formKeyLogin = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool loginError = false;

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
        showIcon: false,
        child: Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.username),
                UsernameField(controller: usernameController),
                Text(AppLocalizations.of(context)!.password),
                PasswordField(controller: passwordController),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Consumer<BlogApi>(builder: (ctx, api, _) {
                      return Center(child: ElevatedButton(
                        onPressed: () {
                          if (_formKeyLogin.currentState!.validate()) {
                            //_formKeyLogin.currentState!.save();
                            api
                                .login(usernameController.text,
                                    passwordController.text)
                                .then((isLoggedIn) {
                              if (isLoggedIn) {
                                Navigator.of(context)
                                    .pop(); // TODO: check if context still valid
                              } else {
                                setState(() {
                                  loginError = true;
                                });
                              }
                            });
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.login),
                      ));
                    }
                    )),
                LoginError(hasError: loginError),
              ],
            )));
  }
}
