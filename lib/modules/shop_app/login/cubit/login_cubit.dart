import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/login_model.dart';

import 'package:salla/modules/shop_app/login/cubit/login_states.dart';
import 'package:salla/shared/network/end_point.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitalStates());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void userLogin({@required String email, @required String password}) {
    emit(ShopLoginLoadingStates());
    // ShopLoginModel loginModel;
    DioHelper.postData(
      path: LOGIN,
      data: {
        'email': '$email',
        'password': '$password',
      },
    ).then((value) {
      //print('${value.data}');
      loginModel = ShopLoginModel.formJson(value.data);
      // print('${loginModel!.data!.name}');
      // print('${loginModel!.message}');
      emit(ShopLoginSuccesStates(loginModel));
    }).catchError((err) {
      print('Errror!!!!${err.toString()}');
      emit(ShopLoginErrorStates(err.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  var isPassword = true;
  void changSuffixIcon() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopChangePasswordVisabilityStates());
  }
}
