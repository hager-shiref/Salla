import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/themes.dart';
import 'package:shop_app/translation/codegen_loader.g.dart';
import 'bloc/bloc_observer.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/remote/dio_helper.dart';
import 'package:easy_localization/easy_localization.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool ?onBoarding= CacheHelper.getData(key: 'onBoarding');
   token= CacheHelper.getData(key: 'token');
   print(token);
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

  runApp( EasyLocalization(
    path: 'assets/translation',
    supportedLocales:const [
      Locale('en'),
      Locale('ar')
    ],
    fallbackLocale:const Locale('en'),
    assetLoader:const CodegenLoader(),
    child: MyApp(startWidget:widget,)));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
   const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> ShopLoginCubit()),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData())
      ],
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
        debugShowCheckedModeBanner: false,
        home: startWidget ,
        theme: lightTheme,
        darkTheme: darkTheme,
      );
        },
      ),
    );
  }
}
