import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:salla/layout/Shop_Layout/shop_layout_screen.dart';
import 'package:salla/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:salla/modules/shop_app/login/cubit/login_states.dart';
import 'package:salla/modules/shop_app/register/shop_register_screen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';

class LoginScreen extends StatelessWidget {
  // const LoginScreen();

  var email = TextEditingController();
  var password = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, states) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          "Login now to browes our hot offers",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormText(
                            controller: email,
                            type: TextInputType.emailAddress,
                            lable: "Email Address",
                            prefixIcon: Icons.email,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter email address';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormText(
                            controller: password,
                            type: TextInputType.visiblePassword,
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            onSubmit: (value) {
                              if (formkey.currentState.validate()) {
                                // print('email: ${email.text}');
                                // print(email.text);
                                // print('password: ${password.text}');
                                ShopLoginCubit.get(context).userLogin(
                                  email: email.text.toString(),
                                  password: password.text.toString(),
                                );
                              }
                            },
                            suffixOnPressed: () {
                              ShopLoginCubit.get(context).changSuffixIcon();
                            },
                            lable: "Password",
                            prefixIcon: Icons.lock,
                            suffixicon: ShopLoginCubit.get(context).suffix,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter password text';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        Conditional.single(
                          conditionBuilder: (context) =>
                              states is! ShopLoginLoadingStates,
                          context: context,
                          widgetBuilder: (context) => Container(
                            width: double.infinity,
                            height: 50,
                            //margin: const EdgeInsetsDirectional.only(start: 70, end: 70),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: MaterialButton(
                              color: defaultColor,
                              onPressed: () {
                                if (formkey.currentState.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: email.text,
                                    password: password.text,
                                  );
                                }
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          fallbackBuilder: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text('Register'.toUpperCase())),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, states) {
          if (states is ShopLoginSuccesStates) {
            if (states.loginModel.status) {
              //print(states.loginModel.message);
              showToast(
                background: Colors.green,
                msg: states.loginModel.message,
              );
              CacheHelper.saveUserData(
                key: 'token',
                value: states.loginModel.data.token,
              ).then((value) {
                token = states.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });

              /*  Fluttertoast.showToast(
                  msg: states.loginModel.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);*/
              print('tokkenenne =>${states.loginModel.data.token} ');
            } else {
              print(states.loginModel.message);
              showToast(
                background: Colors.red,
                msg: states.loginModel.message,
              );
              /* Fluttertoast.showToast(
                  msg: states.loginModel.message,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);*/
            }
          }
        },
      ),
    );
  }
}
