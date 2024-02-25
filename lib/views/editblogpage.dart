import 'package:flutter/material.dart';
import 'package:frogger/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:provider/provider.dart';

class EditblogView extends StatefulWidget {
  const EditblogView({super.key});

  @override
  EditblogViewState createState() {
    return EditblogViewState();
  }
}

class EditblogViewState extends State<EditblogView> {
  final _formKeyLogin = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
        showIcon: false,
        child: Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                Text(AppLocalizations.of(context)!.blogentrytitle),
                //
                Text(AppLocalizations.of(context)!.blogentrycontent),
                //
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Consumer<BlogApi>(builder: (ctx, api, _) {
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKeyLogin.currentState!.validate()) {
                          //_formKeyLogin.currentState!.save();
                          //api
                          
                          Navigator.of(context).pop(); // TODO check if still valid
                        }
                      },
                      child: Text(AppLocalizations.of(context)!.save),
                    );
                  }
                )),
              ],
            )));
  }
}
