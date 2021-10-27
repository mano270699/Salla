import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:salla/layout/Shop_Layout/shop_layout_screen.dart';
import 'package:salla/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:salla/modules/shop_app/login/cubit/login_states.dart';
import 'package:salla/modules/shop_app/login/login_screen.dart';
import 'package:salla/modules/shop_app/register/cubit/login_cubit.dart';
import 'package:salla/modules/shop_app/register/cubit/login_states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/styles/colors.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, states) {
          if (states is ShopRegisterSuccesStates) {
            if (states.LoginModel.status) {
              //print(states.loginModel.message);
              showToast(
                background: Colors.green,
                msg: states.LoginModel.message,
              );
              CacheHelper.saveUserData(
                key: 'token',
                value: states.LoginModel.data.token,
              ).then((value) {
                token = states.LoginModel.data.token;
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
              print(states.LoginModel.data.token);
            } else {
              print(states.LoginModel.message);
              showToast(
                background: Colors.red,
                msg: states.LoginModel.message,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register".toUpperCase(),
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                              ),
                        ),
                        Text(
                          "Register now to browes our hot offers",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormText(
                            controller: name,
                            type: TextInputType.name,
                            lable: "Name",
                            prefixIcon: Icons.person,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15.0,
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
                            controller: phone,
                            type: TextInputType.phone,
                            lable: "Phone",
                            prefixIcon: Icons.phone_android,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter Phone number';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormText(
                            controller: password,
                            type: TextInputType.visiblePassword,
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            onSubmit: (value) {
                              if (formKey.currentState.validate()) {
                                // print('email: ${email.text}');
                                // print(email.text);
                                // print('password: ${password.text}');
                                ShopRegisterCubit.get(context).userRegister(
                                  name: name.text.toString(),
                                  phone: phone.text.toString(),
                                  email: email.text.toString(),
                                  password: password.text.toString(),
                                );
                              }
                            },
                            suffixOnPressed: () {
                              ShopRegisterCubit.get(context).changSuffixIcon();
                            },
                            lable: "Password",
                            prefixIcon: Icons.lock,
                            suffixicon: ShopRegisterCubit.get(context).suffix,
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
                              state is! ShopRegisterLoadingStates,
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
                                if (formKey.currentState.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                    name: name.text.toString(),
                                    phone: phone.text.toString(),
                                    email: email.text.toString(),
                                    password: password.text.toString(),
                                  );
                                }
                              },
                              child: Text(
                                'Register'.toUpperCase(),
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
                            Text('Already have account!'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, LoginScreen());
                                },
                                child: Text('Login'.toUpperCase())),
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
      ),
    );
  }
}
