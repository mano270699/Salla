import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salla/models/shop_app/Favorite_model.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/styles/colors.dart';

Widget MyDiver() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  @required String text,
  @required Function function,
}) =>
    Container(
      width: width,

      //margin: const EdgeInsetsDirectional.only(start: 70, end: 70),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultFormText({
  @required TextEditingController controller,
  IconData suffixicon,
  @required TextInputType type,
  @required String lable,
  bool isPassword = false,
  VoidCallback onTap,
  VoidCallback onChange,
  VoidCallback suffixOnPressed,
  @required IconData prefixIcon,
  @required FormFieldValidator validate,
  ValueChanged onSubmit,
}) =>
    TextFormField(
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      controller: controller,
      validator: validate,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: lable,
          suffixIcon: IconButton(
            onPressed: suffixOnPressed,
            icon: Icon(suffixicon),
          ),
          prefixIcon: Icon(prefixIcon)),
      onTap: onTap,
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

showToast({
  @required String msg,
  Toast toastLength = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
  @required Color background,
  Color textColor = Colors.white,
  fontsize = 16.0,
  timeInSecForIosWeb = 1,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength,
        gravity: gravity,
        timeInSecForIosWeb: timeInSecForIosWeb,
        backgroundColor: background,
        textColor: textColor,
        fontSize: fontsize);

Widget buildProductItem(model, BuildContext context,
        {bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image,
                  ),
                  width: 120,
                  height: 120,
                ),
                if (model.discount != 0 && isOldPrice)
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
            SizedBox(
              width: 10,
            ),
            Expanded(
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
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
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
      ),
    );
Widget noData(context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/emptyfav.png'),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'NoData',
          )
        ],
      ),
    );
