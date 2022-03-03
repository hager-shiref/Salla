// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "login": "تسجيل الدخول",
  "login Now": "سجل الأن حتي تتصفح منتجاتنا الرائعة",
  "Email Address": "البريد الالكتروني ",
  "Password": "كلمة السر ",
  "Don't have an account?": "أليس لديك حساب ؟",
  "Register": "سجل الان ",
  "Register Now": " سجل الأن حتي تتصفح منتجاتنا الرائعة ",
  "Username": "اسمك",
  "Phone": "رقم الهاتف",
  "Home": "الصفحه الرئيسية",
  "Categories": "المنتجات",
  "Favourites": "المفضلة",
  "Settings": "الاعدادات",
  "New Products": "المنتجات الجديده",
  "Discount": "خصم",
  "Search": "البحث",
  "Update": "تحديث ",
  "Logout": "تسجيل الدخول"
};
static const Map<String,dynamic> en = {
  "login": "login",
  "login Now": "Login now to browse our hot offers",
  "Email Address": "Email Address",
  "Password": "Password",
  "Don't have an account?": "Don't have an account",
  "Register": "Register",
  "Register Now": "Register Now to browse our hot offers",
  "Username": "Username",
  "Phone": "Phone",
  "Home": "Home",
  "Categories": "Categories",
  "Favourites": "Favourites",
  "Settings": "Settings",
  "New Products": "New Products",
  "Discount": "Discount",
  "Search": "Search",
  "Update": "Update",
  "Logout": "logout"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
