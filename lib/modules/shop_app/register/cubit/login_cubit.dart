import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/login_model.dart';

import 'package:salla/modules/shop_app/register/cubit/login_states.dart';
import 'package:salla/shared/network/end_point.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitalStates());
  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel;
  void userRegister({
    @required String name,
    @required String phone,
    @required String email,
    @required String password,
  }) {
    emit(ShopRegisterLoadingStates());
    // ShopRegisterModel RegisterModel;
    DioHelper.postData(
      path: REGISTER,
      data: {
        'name': '$name',
        'email': '$email',
        'phone': '$phone',
        'password': '$password',
      },
    ).then((value) {
      //print('${value.data}');
      loginModel = ShopLoginModel.formJson(value.data);
      // print('${RegisterModel!.data!.name}');
      // print('${RegisterModel!.message}');
      emit(ShopRegisterSuccesStates(loginModel));
    }).catchError((err) {
      print('Errror!!!!${err.toString()}');
      emit(ShopRegisterErrorStates(err.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  var isPassword = true;
  void changSuffixIcon() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ShopRegisterfChangePasswordVisabilityStates());
  }
}
