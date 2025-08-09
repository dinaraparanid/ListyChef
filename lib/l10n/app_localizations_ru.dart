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
  String get ok => 'ОК';

  @override
  String get cancel => 'Отмена';

  @override
  String get error => 'Ошибка';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

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

  @override
  String get auth_error_email_empty =>
      'Электронная почта не должна быть пустой';

  @override
  String get auth_error_nickname_empty => 'Никнейм не должен быть пустым';

  @override
  String get auth_error_short_password =>
      'Пароль должен содержать от 8 символов';

  @override
  String get auth_error_invalid_email => 'Неверный адрес электронной почты';

  @override
  String get auth_error_user_disabled => 'Ваш аккаунт отключён';

  @override
  String get auth_error_wrong_password => 'Неверный пароль';

  @override
  String get auth_error_too_many_requests =>
      'Превышено количество запросов. Попробуйте снова позже';

  @override
  String get auth_error_user_token_expired =>
      'Максимальная продолжительность сессии превышена. Для продолжения войдите повторно';

  @override
  String get auth_error_network_request_failed =>
      'Ошибка сетевого соединения. Проверьте подключение к Интернету';

  @override
  String get auth_error_invalid_credential =>
      'Недействительные данные для входа. Пожалуйста, попробуйте ещё раз';

  @override
  String get auth_error_weak_password => 'Пароль недостаточно сложный';

  @override
  String get auth_error_unknown =>
      'Неизвестная ошибка. Повторите попытку позднее';

  @override
  String auth_error_user_not_found(String email) {
    return 'Аккаунта с указанным email $email не существует';
  }

  @override
  String auth_error_email_already_in_use(String email) {
    return 'Пользователь с email `$email` уже существует. Хотите войти?';
  }

  @override
  String get main_tab_folders => 'Папки';

  @override
  String get main_tab_transfer => 'Трансфер';

  @override
  String get main_tab_profile => 'Профиль';

  @override
  String get main_action_add => 'Добавить';

  @override
  String get folder_item_field_placeholder => 'Название';

  @override
  String get folder_item_label_added => 'Добавленное';

  @override
  String get folder_item_error_add => 'Не получилось создать новый элемент';

  @override
  String get folder_item_error_check => 'Не получилось отметить элемент';

  @override
  String get folder_item_error_uncheck =>
      'Не получилось снять отметку с элемента';

  @override
  String get folder_item_error_delete => 'Не получилось удалить элемент';

  @override
  String get folder_item_error_update => 'Не получилось обновить элемент';

  @override
  String get folder_item_action_edit => 'Редактировать';

  @override
  String get folder_item_action_delete => 'Удалить';
}
