import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/l10n/app_localizations.dart';

extension BuildContextExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
