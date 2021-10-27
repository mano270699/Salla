import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/Favorite_model.dart';
import 'package:salla/models/shop_app/cart_model.dart';
import 'package:salla/models/shop_app/category_model.dart';
import 'package:salla/models/shop_app/change_favorite_model.dart';
import 'package:salla/models/shop_app/login_model.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/models/shop_app/home_model.dart';
import 'package:salla/modules/shop_app/categories/category_screen.dart';
import 'package:salla/modules/shop_app/favorites/favorit_screen.dart';
import 'package:salla/modules/shop_app/products/product_screen.dart';
import 'package:salla/modules/shop_app/setting/setting_screen.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/end_point.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopStateInit());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int cartProductsNumber = 0;
  int favProductsNumber = 0;
  Map<int, bool> inCart = {};
  Map<int, bool> favorite = {};
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business_center_outlined),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];
  List<Widget> screens = [
    ProductScreen(),
    CategoryScreen(),
    FavoritScreen(),
    SettingScreen(),
  ];
  void changeBottomNavBar(int index) {
    currentIndex = index;
    //if (currentIndex == 1) getSports();
    // if (currentIndex == 2) getScience();
    // emit(NewsNavBottomState());
    emit(ShopLayoutChangBottomNavState());
  }

  HomeModel homeModel;

  void getHomeData() {
    emit(ShopHomeLoadingState());
    favorite.clear();
    inCart.clear();
    cartProductsNumber = 0;
    favProductsNumber = 0;

    DioHelper.getData(
      path: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorite.addAll({
          element.id: element.inFavorites,
        });
        inCart.addAll({element.id: element.inCart});
        if (element.inCart) cartProductsNumber++;
        if (element.inFavorites) favProductsNumber++;
      });
      print(favorite.toString());
      print("token=> $token");
      print(homeModel.data.banners[1].image);
      //printFullText(homeModel.toString());
      emit(ShopHomeSuccessState());
    }).catchError((err) {
      print(" error =>${err.toString()}");
      emit(ShopHomeErrorState(err.toString()));
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    emit(ShopHomeLoadingState());

    DioHelper.getData(
      path: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.formJson(value.data);

      //printFullText(homeModel.toString());
      emit(ShopCategorySuccessState());
    }).catchError((err) {
      print(" error =>${err.toString()}");
      emit(ShopCategoryErrorState(err.toString()));
    });
  }

  FavoriteModel favoriteModel;
  void getFavoritesData() {
    emit(ShopGetLoadingFavState());
    DioHelper.getData(
      path: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      //printFullText(homeModel.toString());
      emit(ShopGetFavSuccessState());
    }).catchError((err) {
      print(" error =>${err.toString()}");
      emit(ShopGetFavErrorState(err.toString()));
    });
  }

  ShopLoginModel shopLoginModel;
  void getUserData() {
    emit(ShopLoadingSettingState());
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.formJson(value.data);

      printFullText(shopLoginModel.data.token.toString());
      emit(ShopGetSettingSuccessState(shopLoginModel));
    }).catchError((err) {
      emit(ShopGetSettingErrorState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingUpdateState());
    DioHelper.putData(
      path: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      shopLoginModel = ShopLoginModel.formJson(value.data);

      //printFullText(homeModel.toString());
      emit(ShopUpdateSuccessState(shopLoginModel));
    }).catchError((err) {
      emit(ShopUpdateErrorState());
    });
  }

  ChangeFavoriteModel changeFavoriteModel;
  void changeFavorite(int productId) {
    favorite[productId] = !favorite[productId];
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
            path: FAVORITES,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);

      if (!categoriesModel.status) {
        favorite[productId] = !favorite[productId];
      } else {
        getFavoritesData();
      }
      emit(ShopChangeFavoriteSuccessState(changeFavoriteModel));
    }).catchError((err) {
      favorite[productId] = !favorite[productId];
      emit(ShopChangeFavoriteErrorState(err.toString()));
    });
  }

  CartModel cartModel;

  void getCartsData() {
    emit(CartLoadingState());

    DioHelper.getData(
      path: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);

      printFullText(cartModel.data.cartItems[1].product.description);
      emit(CartSuccessState());
    }).catchError((err) {
      print(" error =>${err.toString()}");
      emit(CartErrorState());
    });
  }

  ChangeFavoriteModel changeCartModel;
  void changeCart(int productId) {


    inCart[productId] = !inCart[productId];
    emit(ShopChangeCartState());
    DioHelper.postData(
            path: CARTS,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
          
      changeCartModel = ChangeFavoriteModel.fromJson(value.data);
      if (!categoriesModel.status) {
        inCart[productId] = !inCart[productId];
      } else {
        getCartsData();
      }
      emit(ShopChangeCartSuccessState(changeCartModel));
    }).catchError((err) {
      inCart[productId] = !inCart[productId];
      emit(ShopChangeCartErrorState(err.toString()));
    });
  }

  void changeLocalCart(id) {
    //inCart[id] = !inCart[id];
    if (!inCart[id]) {
      cartProductsNumber--;
      print('cartProductsNumber: $cartProductsNumber');
    } else {
      cartProductsNumber++;
      print('cartProductsNumber: $cartProductsNumber');
    }
  }
}
