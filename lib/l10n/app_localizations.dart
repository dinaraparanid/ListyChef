import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Listy Chef'**
  String get app_name;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @auth_welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Listy Chef!'**
  String get auth_welcome_title;

  /// No description provided for @auth_email_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get auth_email_label;

  /// No description provided for @auth_nickname_label.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get auth_nickname_label;

  /// No description provided for @auth_password_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get auth_password_label;

  /// No description provided for @auth_sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get auth_sign_in;

  /// No description provided for @auth_sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get auth_sign_up;

  /// No description provided for @auth_error_email_empty.
  ///
  /// In en, this message translates to:
  /// **'Email must not be empty'**
  String get auth_error_email_empty;

  /// No description provided for @auth_error_nickname_empty.
  ///
  /// In en, this message translates to:
  /// **'Nickname must not be empty'**
  String get auth_error_nickname_empty;

  /// No description provided for @auth_error_short_password.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 symbols'**
  String get auth_error_short_password;

  /// No description provided for @auth_error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get auth_error_invalid_email;

  /// No description provided for @auth_error_user_disabled.
  ///
  /// In en, this message translates to:
  /// **'Your account is disabled'**
  String get auth_error_user_disabled;

  /// No description provided for @auth_error_wrong_password.
  ///
  /// In en, this message translates to:
  /// **'Invalid password'**
  String get auth_error_wrong_password;

  /// No description provided for @auth_error_too_many_requests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Try again later'**
  String get auth_error_too_many_requests;

  /// No description provided for @auth_error_user_token_expired.
  ///
  /// In en, this message translates to:
  /// **'The maximum session duration has been exceeded. To continue, please log in again.'**
  String get auth_error_user_token_expired;

  /// No description provided for @auth_error_network_request_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to make a network request. Please, check your internet connection'**
  String get auth_error_network_request_failed;

  /// No description provided for @auth_error_invalid_credential.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please, try again'**
  String get auth_error_invalid_credential;

  /// No description provided for @auth_error_weak_password.
  ///
  /// In en, this message translates to:
  /// **'Password must be stronger'**
  String get auth_error_weak_password;

  /// No description provided for @auth_error_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown error. Please, try again'**
  String get auth_error_unknown;

  /// No description provided for @auth_error_user_not_found.
  ///
  /// In en, this message translates to:
  /// **'Account with email `{email}` does not exist'**
  String auth_error_user_not_found(String email);

  /// No description provided for @auth_error_email_already_in_use.
  ///
  /// In en, this message translates to:
  /// **'User with email `{email}` already exists. Do you want to sign in?'**
  String auth_error_email_already_in_use(String email);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
