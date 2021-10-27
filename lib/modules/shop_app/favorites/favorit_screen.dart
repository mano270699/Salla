import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:salla/models/shop_app/Favorite_model.dart';
import 'package:salla/models/shop_app/category_model.dart';
import 'package:salla/models/shop_app/home_model.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/shammer.dart';
import 'package:salla/shared/styles/colors.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //var favItem = ShopCubit.get(context).favoriteModel.data.data;
          return Conditional.single(
            fallbackBuilder: (context) =>
                Center(child: CircularProgressIndicator()),
            context: context,
            conditionBuilder: (context) =>
                ShopCubit.get(context).favoriteModel != null,
            widgetBuilder: (context) => ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildProductItem(
                    ShopCubit.get(context)
                        .favoriteModel
                        .data
                        .data[index]
                        .product,
                    context,
                    isOldPrice: true),
                separatorBuilder: (context, index) => MyDiver(),
                itemCount:
                    ShopCubit.get(context).favoriteModel.data.data.length),
          );
        });
  }
}
