import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frogger/models/blog.dart';
import 'package:provider/provider.dart';

class DeleteBlogButton extends StatelessWidget {
  final String blogId;

  const DeleteBlogButton({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final blog = Provider.of<Blog?>(context, listen: false);
        blog?.deleteBlog(blogId);
        Navigator.of(context).pop(); // TODO: check if context still valid
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
