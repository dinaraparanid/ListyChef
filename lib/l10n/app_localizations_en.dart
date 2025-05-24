// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Listy Chef';

  @override
  String get auth_welcome_title => 'Welcome to Listy Chef!';

  @override
  String get auth_email_label => 'Email';

  @override
  String get auth_nickname_label => 'Nickname';

  @override
  String get auth_password_label => 'Password';

  @override
  String get auth_sign_in => 'Sign In';

  @override
  String get auth_sign_up => 'Sign Up';
}
