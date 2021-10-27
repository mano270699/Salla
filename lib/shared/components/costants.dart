//https://newsapi.org/v2/everything?q=tesla&apiKey=df81b9347da240deb36e7d11547a0471

import 'package:flutter/material.dart';
import 'package:salla/modules/shop_app/login/login_screen.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/network/local/cache_helper.dart';

void signOut({
  @required BuildContext context,
}) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');

  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
