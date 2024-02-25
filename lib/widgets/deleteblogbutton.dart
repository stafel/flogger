import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/routes/editblogview.dart';

class DeleteBlogButton extends StatelessWidget {
  final String blogId;

  const DeleteBlogButton({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // TODO delete
      },
      child: Text(
        AppLocalizations.of(context)!.deleteblog,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }
}
