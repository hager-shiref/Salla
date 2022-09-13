import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/themes.dart';
import 'bloc/bloc_observer.dart';
import 'localization/app_localization.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/remote/dio_helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool ?onBoarding= CacheHelper.getData(key: 'onBoarding');
  token= CacheHelper.getData(key: 'token');
  print("token : $token");
  if(onBoarding !=null){
    if(token !=null){
        widget=const ShopLayout();
    }
    else {
      widget=const LoginScreen();
    }
  }
  else{
    widget=const OnBoardingScreen();
  }

  runApp( MyApp(startWidget:widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
     const MyApp({Key? key, required this.startWidget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //BlocProvider(create: (context)=> ShopLoginCubit()),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData())
      ],
      child: MaterialApp(
        supportedLocales:const [
          Locale('en','US'),
          Locale('ar','')
        ],

        localizationsDelegates:const[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
       localeResolutionCallback: (deviceLocale,supportedLocales)
       {
         for(var locale in supportedLocales){
           if(deviceLocale !=null && deviceLocale.languageCode==locale.languageCode){
             deviceLang=deviceLocale.languageCode;
             return deviceLocale;
           }
         }
         return supportedLocales.first;
       },
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
