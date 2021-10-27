import 'package:salla/models/shop_app/change_favorite_model.dart';
import 'package:salla/models/shop_app/login_model.dart';

abstract class ShopStates {}

class ShopStateInit extends ShopStates {}

class ShopStateLoading extends ShopStates {}

class ShopStateSuccess extends ShopStates {}

class ShopStateError extends ShopStates {
  var error;
  ShopStateError(this.error);
}

class ShopLayoutChangBottomNavState extends ShopStates {}

class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategorySuccessState extends ShopStates {}

class ShopCategoryErrorState extends ShopStates {
  final String error;

  ShopCategoryErrorState(this.error);
}

class ShopChangeFavoriteSuccessState extends ShopStates {
  final ChangeFavoriteModel model;

  ShopChangeFavoriteSuccessState(this.model);
}

class ShopChangeFavoriteState extends ShopStates {}

class ShopChangeFavoriteErrorState extends ShopStates {
  final String error;

  ShopChangeFavoriteErrorState(this.error);
}

class ShopGetFavSuccessState extends ShopStates {}

class ShopGetFavErrorState extends ShopStates {
  final String error;

  ShopGetFavErrorState(this.error);
}

class ShopGetLoadingFavState extends ShopStates {}

class ShopLoadingSettingState extends ShopStates {}

class ShopGetSettingSuccessState extends ShopStates {
  final ShopLoginModel userModel;

  ShopGetSettingSuccessState(this.userModel);
}

class ShopGetSettingErrorState extends ShopStates {}

class ShopLoadingUpdateState extends ShopStates {}

class ShopUpdateSuccessState extends ShopStates {
  final ShopLoginModel userModel;

  ShopUpdateSuccessState(this.userModel);
}

class ShopUpdateErrorState extends ShopStates {}

class CartLoadingState extends ShopStates {}

class CartSuccessState extends ShopStates {}

class AddToOrRemoveCartState extends ShopStates {}

class CartErrorState extends ShopStates {}

class GetCartInfoLoading extends ShopStates {}

class GetCartInfoSuccessState extends ShopStates {}

class GetCartInfoErrorState extends ShopStates {}

class ShopChangeCartSuccessState extends ShopStates {
  final ChangeFavoriteModel model;

  ShopChangeCartSuccessState(this.model);
}

class ShopChangeCartState extends ShopStates {}

class ShopChangeCartErrorState extends ShopStates {
  final String error;

  ShopChangeCartErrorState(this.error);
}
