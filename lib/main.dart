import 'package:bloc/bloc.dart';
import 'package:custom_splash/custom_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:salla/layout/Shop_Layout/shop_layout_screen.dart';
import 'package:salla/modules/shop_app/login/login_screen.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/shared/bloc_observer.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/local/cache_helper.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';
import 'package:salla/shared/styles/theams.dart';

import 'modules/shop_app/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  var onboarding = CacheHelper.getData(key: "onBoarding");
  token = CacheHelper.getData(key: 'token');
  if (onboarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  final Widget startWidget;
  MyApp({@required this.startWidget});
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    // if (a > 100)
    //   return 1;
    // else
    //   return 2;
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavoritesData()
        ..getUserData()
        ..getCartsData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            key: globalScaffoldKey,
            title: 'Salla App',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: lightTheme,
            darkTheme: darkThem,
            home: CustomSplash(
              imagePath: 'assets/images/salla.png',
              backGroundColor: Colors.white,
              animationEffect: 'zoom-in',
              logoSize: 250,
              home: startWidget,
              //customFunction: duringSplash,
              duration: 3500,
              type: CustomSplashType.StaticDuration,
              //outputAndHome: op,
            ),
          );
        },
      ),
    );
  }
}
