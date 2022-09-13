import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'delegate.dart';

class AppLocalizations{
  final Locale? locale;
  AppLocalizations({this.locale});

  //=======================================================================================================================================================
  //to provide delegate class in this class
  static const LocalizationsDelegate<AppLocalizations>delegate= AppLocalizationDelegate();

//=======================================================================================================================================================
  //to know where i am in the widget tree
  static AppLocalizations? of(BuildContext context){
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
//=======================================================================================================================================================

  late Map<String,String>_localizedStrings;

  //=======================================================================================================================================================
  // to load json files
  Future loadJsonLanguage()async{
    String jsonString=await rootBundle.loadString("assets/lang/${locale!.languageCode}.json");

    Map<String,dynamic>jsonMap=json.decode(jsonString);
    _localizedStrings=jsonMap.map((key, value){
       return MapEntry(key, value.toString());
    } );
  }
//=======================================================================================================================================================
  String translate(String key)=> _localizedStrings[key]??"";
}

//=======================================================================================================================================================
extension TranslateX on String{
  String tr(BuildContext context){
    return AppLocalizations.of(context)!.translate(this);
  }
}