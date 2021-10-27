import 'package:flutter/cupertino.dart';

class ShopLayoutStates {}

class ShopLayoutInitalState extends ShopLayoutStates {}

class ShopLayoutChangBottomNavState extends ShopLayoutStates {}

class ShopHomeLoadingState extends ShopLayoutStates {}

class ShopHomeSuccessState extends ShopLayoutStates {}

class ShopHomeErrorState extends ShopLayoutStates {
  final String error;

  ShopHomeErrorState(this.error);
}
