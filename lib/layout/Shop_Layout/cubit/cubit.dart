import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/layout/Shop_Layout/cubit/states.dart';
import 'package:salla/models/shop_app/home_model.dart';
import 'package:salla/modules/shop_app/categories/category_screen.dart';
import 'package:salla/modules/shop_app/favorites/favorit_screen.dart';
import 'package:salla/modules/shop_app/products/product_screen.dart';
import 'package:salla/modules/shop_app/setting/setting_screen.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/end_point.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates> {
  ShopLayoutCubit() : super(ShopLayoutInitalState());

  static ShopLayoutCubit get(context) => BlocProvider.of(context);
}
