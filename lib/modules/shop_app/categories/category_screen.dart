import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:salla/models/shop_app/category_model.dart';
import 'package:salla/modules/shop_app/categories/product_inCategory.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/shammer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // var cat_model = ShopCubit.get(context).categoriesModel.data.datamodel;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              ShopCubit.get(context).categoriesModel != null,
          widgetBuilder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
                onTap: () => navigateTo(context, ProductsCategory()),
                child: buildCatItem(ShopCubit.get(context)
                    .categoriesModel
                    .data
                    .datamodel[index])),
            separatorBuilder: (context, index) => MyDiver(),
            itemCount:
                ShopCubit.get(context).categoriesModel.data.datamodel.length,
          ),
          fallbackBuilder: (context) => ShimmerList(),
        );
      },
    );
  }

  Widget buildCatItem(DataModel cat) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                cat.image,
              ),
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: 170,
              child: Text(
                "${cat.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      );
}
