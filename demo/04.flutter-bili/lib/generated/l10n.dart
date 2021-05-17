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

  /// `开启`
  String get on {
    return Intl.message(
      '开启',
      name: 'on',
      desc: '',
      args: [],
    );
  }

  /// `关闭`
  String get off {
    return Intl.message(
      '关闭',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `夜间模式`
  String get darkMode {
    return Intl.message(
      '夜间模式',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `跟随系统`
  String get followSystem {
    return Intl.message(
      '跟随系统',
      name: 'followSystem',
      desc: '',
      args: [],
    );
  }

  /// `请输入手机号`
  String get loginInputHint {
    return Intl.message(
      '请输入手机号',
      name: 'loginInputHint',
      desc: '',
      args: [],
    );
  }

  /// `请输入密码`
  String get loginInputPasswordHint {
    return Intl.message(
      '请输入密码',
      name: 'loginInputPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `注册`
  String get registration {
    return Intl.message(
      '注册',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get loginButton {
    return Intl.message(
      '登录',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `下一步`
  String get nextButton {
    return Intl.message(
      '下一步',
      name: 'nextButton',
      desc: '',
      args: [],
    );
  }

  /// `注册成功`
  String get registrationSuccess {
    return Intl.message(
      '注册成功',
      name: 'registrationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `获取验证码`
  String get codeButton {
    return Intl.message(
      '获取验证码',
      name: 'codeButton',
      desc: '',
      args: [],
    );
  }

  /// `重新发送`
  String get resendCode {
    return Intl.message(
      '重新发送',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `欢迎使用E社工`
  String get welcomeText {
    return Intl.message(
      '欢迎使用E社工',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `未注册手机号登录后将自动创建账号`
  String get welcomeTextHint {
    return Intl.message(
      '未注册手机号登录后将自动创建账号',
      name: 'welcomeTextHint',
      desc: '',
      args: [],
    );
  }

  /// `手机密码登录`
  String get mobilePasswordLoginText {
    return Intl.message(
      '手机密码登录',
      name: 'mobilePasswordLoginText',
      desc: '',
      args: [],
    );
  }

  /// `输入手机格式错误`
  String get mobileNumErr {
    return Intl.message(
      '输入手机格式错误',
      name: 'mobileNumErr',
      desc: '',
      args: [],
    );
  }

  /// `密码格式错误`
  String get passwordNumErr {
    return Intl.message(
      '密码格式错误',
      name: 'passwordNumErr',
      desc: '',
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