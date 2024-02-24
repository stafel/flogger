import 'package:flutter/material.dart';
import 'package:frogger/models/blog.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Like extends StatelessWidget {
  String blogId;

  Like({
    super.key,
    required this.blogId
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Blog>(builder: (ctx, blog, _) {

      final blogEntry = blog.getById(blogId)!;

      return Row(
        children: [
          blogEntry.totalLikes > 0 ? Text(blogEntry.totalLikes.toString()) : const Text(" "),
          IconButton(
            onPressed: () { 
              final loggedIn = Provider.of<BlogApi?>(context, listen: false)?.isLoggedIn() ?? false; // to allow testing without blogapi provider setup, listen false to prevent rebuild loop
              if (loggedIn) {
                blogEntry.toggleLike();
              } else {
                final snackbarInfo = SnackBar(
                  content: Text(AppLocalizations.of(ctx)!.loginFirst),
                  action: SnackBarAction(label: AppLocalizations.of(ctx)!.login, onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginView())); })
                  );
                ScaffoldMessenger.of(context).showSnackBar(snackbarInfo);
              }
              
            },
            icon: Icon(blogEntry.liked ? Icons.favorite : Icons.favorite_border))
        ]);
    });
  }
}
