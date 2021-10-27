import 'package:salla/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitalStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginSuccesStates extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccesStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;

  ShopLoginErrorStates(this.error);
}

class ShopChangePasswordVisabilityStates extends ShopLoginStates {}
