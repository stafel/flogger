import 'package:flutter/material.dart';
import 'package:frogger/main.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/authorinfo.dart';
import 'package:frogger/views/like.dart';
import 'package:provider/provider.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogEntry entry;

  const BlogDetailPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogEntry>(
      create: (_) => entry,
      child: ReusableScaffold(title: entry.title, showIcon: false, child: Center(
        child: Column(
          children: [
            //const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Authorinfo(), Like()]), // creates problem with notification dispose
            Row( children: [const Text("Body"), Text(entry.content)]),
            Consumer<BlogApi>(builder: (ctx, api, _) {
              if (api.status == BlogApiStatus.conLogin) {
                return Text("Edit");
              }

              return const SizedBox();
            }),
          ]
        )
      )
    ));
  }

}