/*import 'package:shared_preferences/shared_preferences.dart';

class LanguageCacheHelper{
 static Future<void>cacheLanguageCode(String languageCode)async
  {
    final sharedLanguage=await SharedPreferences.getInstance();
    sharedLanguage.setString("LOCALE", languageCode);
  }

  Future<String>getCachedLanguageCode()async{
    final sharedLanguage=await SharedPreferences.getInstance();
    final cachedLanguageCode=sharedLanguage.getString("LOCALE");
    if(cachedLanguageCode !=null){
      return cachedLanguageCode;
    }
    else{
      return "en";
    }
  }
}*/