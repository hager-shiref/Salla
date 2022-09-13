// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/component.dart';

MaterialColor defaultColor = Colors.blue;
//=======================================================================================================================================================

void signOut(context)=>CacheHelper.removeData(key: 'token').then((value) {
              if(value){
                navigateAndFinish(context, const LoginScreen());
              }
              });
//=======================================================================================================================================================
void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token ;

var deviceLang ;
