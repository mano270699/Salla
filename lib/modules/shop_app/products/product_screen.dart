import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:salla/models/shop_app/category_model.dart';
import 'package:salla/shared/app_cubit/app_states.dart';
import 'package:salla/models/shop_app/home_model.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/components/components.dart';
import 'package:salla/shared/components/shammer.dart';
import 'package:salla/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  //const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          widgetBuilder: (context) => productBuilder(
              ShopCubit.get(context).homeModel,
              ShopCubit.get(context).categoriesModel,
              size,
              context),
          fallbackBuilder: (context) => ShimmerList(),
        );
      },
      listener: (context, state) {
        if (state is ShopChangeFavoriteSuccessState) {
          if (!state.model.status) {
            showToast(msg: state.model.message, background: Colors.red);
          } else {
            showToast(msg: state.model.message, background: Colors.green);
          }
        }
      },
    );
  }

  Widget productBuilder(HomeModel model, CategoriesModel categoriesModel, size,
          BuildContext context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
                itemCount: model.data.banners.length,
                itemBuilder: (context, index, realIdx) {
                  return Image(
                    image: NetworkImage(model.data.banners[index].image),
                    fit: BoxFit.cover,
                  );
                },
                options: CarouselOptions(
                  height: size.width > 600 ? 300 : 180,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoryItem(
                              categoriesModel.data.datamodel[index],
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 5,
                            ),
                        itemCount: categoriesModel.data.datamodel.length),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 2,
                children: List.generate(
                    model.data.products.length,
                    (index) =>
                        buildGridItem(model.data.products[index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridItem(Products model, BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeCart(model.id);
                      ShopCubit.get(context).changeLocalCart(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).inCart[model.id]
                          ? defaultColor
                          : Colors.grey[300],
                      child: Icon(
                        ShopCubit.get(context).inCart[model.id] != null &&
                                ShopCubit.get(context).inCart[model.id]
                            ? Icons.shopping_bag
                            : Icons.shopping_bag_outlined,
                        color:
                            ShopCubit.get(context).inCart[model.id] != null &&
                                    ShopCubit.get(context).inCart[model.id]
                                ? Colors.white
                                : Colors.blueGrey,
                      ),
                    )),
              ],
            ),
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: defaultColor,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 8, color: Colors.white),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorite(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor:
                                ShopCubit.get(context).favorite[model.id]
                                    ? defaultColor
                                    : Colors.grey[300],
                            child: Icon(
                              Icons.favorite_border,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel categoriesModel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${categoriesModel.image}'),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            width: 100,
            child: Text(
              '${categoriesModel.name}',
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
