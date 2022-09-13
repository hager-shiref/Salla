
import 'package:flutter/material.dart';
import 'package:shop_app/localization/app_localization.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations>{
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }
//=======================================================================================================================================================

  @override
  Future<AppLocalizations>load(Locale locale) async {
   AppLocalizations localizations=AppLocalizations(locale: locale);
   await localizations.loadJsonLanguage();
   return localizations;
  }
//=======================================================================================================================================================

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
  
}