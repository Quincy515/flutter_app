import 'package:e_social_work/page/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

Handler homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MyHomePage();
});

Handler darkHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return DarkModePage();
});

Handler registrationHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RegistrationPage();
});

Handler mobileHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MobilePage();
});

Handler loginHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MobilePasswordLogin();
});

Handler verificationCodeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  // String mobile = params['mobile'].first;
  String mobile = context.settings.name;
  return VerificationCodePage(mobile);
});

Handler forgetPassword1Handler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return ForgetPasswordPage1();
});

Handler forgetPassword2Handler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String mobile = context.settings.name;

  return ForgetPasswordPage2(mobile);
});

Handler forgetPassword3Handler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String mobile = params['mobile'].first;
  String code = params['code'].first;
  return ForgetPasswordPage3(mobile, code);
});

Handler bindMobile1Handler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return BindMobilePage1();
});
Handler bindMobile2Handler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String mobile = context.settings.name;

  return BindMobilePage2(mobile);
});
