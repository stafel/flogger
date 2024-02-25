import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Display motto
class MottoText extends StatelessWidget {
  const MottoText({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.motto);
  }
}