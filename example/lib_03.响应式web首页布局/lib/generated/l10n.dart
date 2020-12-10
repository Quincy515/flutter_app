// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `welcome {name}`
  String welcome(Object name) {
    return Intl.message(
      'welcome $name',
      name: 'welcome',
      desc: '',
      args: [name],
    );
  }

  /// `Title`
  String get starterAppGenericTitle {
    return Intl.message(
      'Title',
      name: 'starterAppGenericTitle',
      desc: 'Generic placeholder for title in app bar.',
      args: [],
    );
  }

  /// `Share`
  String get starterAppTooltipShare {
    return Intl.message(
      'Share',
      name: 'starterAppTooltipShare',
      desc: 'Tooltip on share icon.',
      args: [],
    );
  }

  /// `Favorite`
  String get starterAppTooltipFavorite {
    return Intl.message(
      'Favorite',
      name: 'starterAppTooltipFavorite',
      desc: 'Tooltip on favorite icon.',
      args: [],
    );
  }

  /// `Search`
  String get starterAppTooltipSearch {
    return Intl.message(
      'Search',
      name: 'starterAppTooltipSearch',
      desc: 'Tooltip on search icon.',
      args: [],
    );
  }

  /// `Head`
  String get starterAppGenericHeadline {
    return Intl.message(
      'Head',
      name: 'starterAppGenericHeadline',
      desc: '',
      args: [],
    );
  }

  /// `Subtitle`
  String get starterAppGenericSubtitle {
    return Intl.message(
      'Subtitle',
      name: 'starterAppGenericSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `body`
  String get starterAppGenericBody {
    return Intl.message(
      'body',
      name: 'starterAppGenericBody',
      desc: '',
      args: [],
    );
  }

  /// `Starter app`
  String get starterAppTitle {
    return Intl.message(
      'Starter app',
      name: 'starterAppTitle',
      desc: 'The title and name for the starter app.',
      args: [],
    );
  }

  /// `Item {value}`
  String starterAppDrawerItem(Object value) {
    return Intl.message(
      'Item $value',
      name: 'starterAppDrawerItem',
      desc: '',
      args: [value],
    );
  }

  /// `BUTTON`
  String get starterAppGenericButton {
    return Intl.message(
      'BUTTON',
      name: 'starterAppGenericButton',
      desc: 'Generic placeholder for button.',
      args: [],
    );
  }

  /// `Add`
  String get starterAppTooltipAdd {
    return Intl.message(
      'Add',
      name: 'starterAppTooltipAdd',
      desc: 'Tooltip on add icon.',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}