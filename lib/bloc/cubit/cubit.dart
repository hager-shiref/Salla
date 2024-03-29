// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/favourites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories.dart';
import 'package:shop_app/modules/favourite/favorite.dart';
import 'package:shop_app/modules/products/products.dart';
import 'package:shop_app/modules/settings/settings.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';
import 'package:shop_app/shared/constant.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  //var cachedLanguageCode="en";
  //=======================================================================================================================================================
  int currentIndex = 0;
  List<Widget> screen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    SettingsScreen()
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottom());
  }

//=======================================================================================================================================================
  HomeModel? homeModel;
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME, token: token,deviceLang: deviceLang).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favourites.addAll({element.id!: element.inFavorites!});
      }
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }

  //=======================================================================================================================================================
  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES, deviceLang:deviceLang ,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  //=======================================================================================================================================================
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
            url: FAVOURITES, data: {'product_id': productId}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favourites[productId] = !favourites[productId]!;
      emit(ShopErrorChangeFavoritesState(error));
    });
  }
  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url: FAVOURITES, token: token,deviceLang: deviceLang).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState(error.toString()));
    });
  }
//=======================================================================================================================================================
  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(url: PROFILE, token: token,deviceLang: deviceLang).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print("UserModel : $value.data");
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  //=======================================================================================================================================================
  void updateUserData({
    required String name,
    required String email,
    required String phone,
}){
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
      url:UPDATE_PROFILE,
      token:token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      }
    ).then((value)
    {

      userModel=ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataState(userModel!));
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    }
    );
  }
//=======================================================================================================================================================


  /*Future <void>getSavedLanguage()async{
    cachedLanguageCode=await LanguageCacheHelper().getCachedLanguageCode();
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode)));
  }

  Future<void>changeLanguage(String languageCode)async{
    await  LanguageCacheHelper.cacheLanguageCode(languageCode);
    emit(ChangeLocaleState(locale: Locale(languageCode)));

  }
*/
}
