import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/models/blog.dart';
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
            child: Consumer<Blog>(builder: (ctx, blog, _) { 
                    return Column(
              children: [
                TextFormField(
                  controller: titleController..text = widget.blogId == null ? "" : blog.getById(widget.blogId!)!.title,
                  autofocus: true, // focus this field as soon as it is visible
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.emptyError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: const UnderlineInputBorder(), labelText: AppLocalizations.of(context)!.blogentrytitle),
                ),
                TextFormField(
                  controller: contentController..text = widget.blogId == null ? "" : blog.getById(widget.blogId!)!.content,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.emptyError;
                    }
                    return null;
                  },
                  decoration: InputDecoration(border: const UnderlineInputBorder(), labelText: AppLocalizations.of(context)!.blogentrycontent),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(child: ElevatedButton(
                    onPressed: () {
                      if (_formKeyLogin.currentState!.validate()) {
                        //_formKeyLogin.currentState!.save();

                        if (widget.blogId == null) {
                          blog.createBlogSimple(titleController.text, contentController.text);
                        } else {
                          blog.updateBlogSimple(widget.blogId!, titleController.text, contentController.text);
                        }
                        
                        Navigator.of(context).pop(); // TODO check if still valid
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save),
                  )
                )),
              ]);
            })
          ));
  }
}
