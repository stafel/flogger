import 'package:flutter/material.dart';
import 'package:frogger/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/widgets/reusablescaffold.dart';
import 'package:provider/provider.dart';

class EditblogView extends StatefulWidget {
  final String? blogId;

  const EditblogView({super.key, this.blogId});

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
        title: widget.blogId == null ? AppLocalizations.of(context)!.createblog : AppLocalizations.of(context)!.editblog,
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

                          if (widget.blogId == null) {
                            // new blog
                          } else {
                            // edit existing
                          }
                          
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
