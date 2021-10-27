import 'package:salla/models/shop_app/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitalStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegisterSuccesStates extends ShopRegisterStates {
  final ShopLoginModel LoginModel;

  ShopRegisterSuccesStates(this.LoginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorStates(this.error);
}

class ShopRegisterfChangePasswordVisabilityStates extends ShopRegisterStates {}
