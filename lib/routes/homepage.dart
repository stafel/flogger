import 'package:flutter/material.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/widgets/bloglist.dart';
import 'package:frogger/widgets/mottotext.dart';
import 'package:frogger/widgets/newblogbutton.dart';
import 'package:frogger/widgets/reusablescaffold.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(showIcon: true, showDrawer: true, child: Center(
          child: Column(
            children: [
              const MottoText(),
              const BlogList(),
              Consumer<BlogApi>(builder: (ctx, api, _) {
                if (api.status == BlogApiStatus.conLogin) {
                return const NewBlogButton();
                }

                return const SizedBox();
              }),
            ],
          ),
        )
    );
  }
}
