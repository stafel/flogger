import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/views/editblogview.dart';

class EditBlogButton extends StatelessWidget {
  final String blogId;

  const EditBlogButton({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => EditblogView(blogId: blogId)));
      },
      child: Text(
        AppLocalizations.of(context)!.editblog,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
