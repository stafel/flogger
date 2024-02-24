import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Authorinfo extends StatelessWidget {
  const Authorinfo({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogEntry>(builder: (ctx, entry, _) {
      return Align(
        alignment: Alignment.topLeft,
        child: Text("by ${entry.author.username} on ${entry.creationDate}"),
      );
    });
  }
}
