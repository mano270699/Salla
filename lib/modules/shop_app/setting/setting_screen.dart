import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:salla/modules/shop_app/Splash/splash_screen.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/components/shammer.dart';

class SettingScreen extends StatelessWidget {
  //const SettingScreen({Key key}) : super(key: key);
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Conditional.single(
              context: context,
              conditionBuilder: (context) =>
                  ShopCubit.get(context).shopLoginModel != null,
              widgetBuilder: (context) {
                var model = ShopCubit.get(context).shopLoginModel;
                nameControler.text = model.data.name;
                emailControler.text = model.data.email;
                phoneControler.text = model.data.phone;
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (state is ShopLoadingUpdateState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormText(
                              controller: nameControler,
                              type: TextInputType.name,
                              lable: 'Name',
                              prefixIcon: Icons.person,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name!';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormText(
                              controller: emailControler,
                              type: TextInputType.emailAddress,
                              lable: 'Email',
                              prefixIcon: Icons.email,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your name!';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormText(
                              controller: phoneControler,
                              type: TextInputType.phone,
                              lable: 'Phone',
                              prefixIcon: Icons.phone,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your Phone!';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (formKey.currentState.validate()) {
                                ShopCubit.get(context).updateUserData(
                                  email: emailControler.text,
                                  name: nameControler.text,
                                  phone: phoneControler.text,
                                );
                              }
                            },
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Update'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            onPressed: () {
                              signOut(context: context);
                            },
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Logout'.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              fallbackBuilder: (context) =>
                  Center(child: CircularProgressIndicator()));
        });
  }
}
