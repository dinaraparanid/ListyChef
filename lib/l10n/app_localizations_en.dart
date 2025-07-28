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
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get error => 'Error';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

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

  @override
  String get auth_error_email_empty => 'Email must not be empty';

  @override
  String get auth_error_nickname_empty => 'Nickname must not be empty';

  @override
  String get auth_error_short_password =>
      'Password must contain at least 8 symbols';

  @override
  String get auth_error_invalid_email => 'Invalid email';

  @override
  String get auth_error_user_disabled => 'Your account is disabled';

  @override
  String get auth_error_wrong_password => 'Invalid password';

  @override
  String get auth_error_too_many_requests =>
      'Too many requests. Try again later';

  @override
  String get auth_error_user_token_expired =>
      'The maximum session duration has been exceeded. To continue, please log in again.';

  @override
  String get auth_error_network_request_failed =>
      'Failed to make a network request. Please, check your internet connection';

  @override
  String get auth_error_invalid_credential =>
      'Invalid credentials. Please, try again';

  @override
  String get auth_error_weak_password => 'Password must be stronger';

  @override
  String get auth_error_unknown => 'Unknown error. Please, try again';

  @override
  String auth_error_user_not_found(String email) {
    return 'Account with email `$email` does not exist';
  }

  @override
  String auth_error_email_already_in_use(String email) {
    return 'User with email `$email` already exists. Do you want to sign in?';
  }

  @override
  String get main_tab_cart => 'Cart';

  @override
  String get main_tab_recipes => 'Recipes';

  @override
  String get main_tab_profile => 'Profile';

  @override
  String get main_action_add => 'Add';

  @override
  String get cart_product_field_placeholder => 'Product title';

  @override
  String get cart_label_added => 'Added';

  @override
  String get cart_error_product_add =>
      'Failed to create new product on the server';

  @override
  String get cart_action_edit => 'Edit';

  @override
  String get cart_action_delete => 'Delete';
}
