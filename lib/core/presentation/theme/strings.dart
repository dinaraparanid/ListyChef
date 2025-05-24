import 'package:flutter/material.dart';
import 'package:listy_chef/l10n/app_localizations.dart';

extension AppStrings on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;
}
