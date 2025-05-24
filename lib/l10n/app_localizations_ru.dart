// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get app_name => 'Listy Chef';

  @override
  String get auth_welcome_title => 'Добро пожаловать в Listy Chef!';

  @override
  String get auth_email_label => 'Электронная почта';

  @override
  String get auth_nickname_label => 'Никнейм';

  @override
  String get auth_password_label => 'Пароль';

  @override
  String get auth_sign_in => 'Войти';

  @override
  String get auth_sign_up => 'Зарегистрироваться';
}
