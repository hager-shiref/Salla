import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login_screen/cubit/cubit.dart';
import 'package:shop_app/modules/login_screen/cubit/states.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/network/local/cach_helper.dart';
import 'package:shop_app/shared/themes.dart';
import 'bloc/bloc_observer.dart';
import 'modules/on_boarding/on_boarding_screen.dart';
import 'network/remote/dio_helper.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool ?onBoarding= CacheHelper.getData(key: 'onBoarding');
  String? token= CacheHelper.getData(key: 'token');
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

  runApp( MyApp(startWidget:widget,));
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
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: startWidget,
      ),
    );
  }
}
