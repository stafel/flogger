import 'package:flutter/material.dart';
import 'package:frogger/models/blog.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/widgets/blogcard.dart';
import 'package:frogger/widgets/newblogbutton.dart';
import 'package:frogger/widgets/logodrawer.dart';
import 'package:frogger/widgets/customdrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// displays a list of all blogs
// if loading displays spinner
// if error displays generic message
class BlogList extends StatelessWidget {
  const BlogList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Blog>(builder: (ctx, blog, _) {
      if (blog.state == BlogState.loading) {
        return const CircularProgressIndicator();
      }

      if (blog.state == BlogState.error) {
        return Text(AppLocalizations.of(ctx)!.connectionError);
      }

      return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
              itemCount: blog.items.length,
              itemBuilder: (BuildContext context, int index) {
                return BlogCard(blogId: blog.items[index].id);
              }));
    });
  }
}