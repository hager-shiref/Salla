import 'package:shop_app/models/change_favourites_model.dart';
import 'package:shop_app/models/login_model.dart';
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottom extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates
{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(this.model);
}

class ShopErrorChangeFavoritesState extends ShopStates {
  final String error;
  ShopErrorChangeFavoritesState(this.error);
}

class ShopSuccessFavoritesState extends ShopStates {}
class ShopLoadingGetFavoritesState extends ShopStates {}
class ShopErrorFavoritesState extends ShopStates
{
  final String error;

  ShopErrorFavoritesState(this.error);
}

class ShopSuccessUserDataState extends ShopStates {}
class ShopLoadingUserDataState extends ShopStates {}
class ShopErrorUserDataState extends ShopStates
{
  final String error;

  ShopErrorUserDataState(this.error);
}

class ShopSuccessUpdateUserDataState extends ShopStates {
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserDataState(this.loginModel);
}
class ShopLoadingUpdateUserDataState extends ShopStates {}
class ShopErrorUpdateUserDataState extends ShopStates
{
  final String error;

  ShopErrorUpdateUserDataState(this.error);
}

/*class ChangeLocaleState extends ShopStates{
  final Locale locale;
  ChangeLocaleState({required this.locale});}*/