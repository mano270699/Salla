import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:salla/shared/app_cubit/app_cubit.dart';
import 'package:salla/shared/app_cubit/app_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
  var model= ShopCubit.get(context).cartModel;
          return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: AppBar(
                title: Text('cart'),
                elevation: 1.0,
              ),
              body: SafeArea(
                child: Conditional.single(context: context, conditionBuilder: (context) => ShopCubit.get(context).cartModel!=null, widgetBuilder:  (context) => 
                
                
                Conditional.single(context: context, conditionBuilder: (context)=>model.data != null && model.data.cartItems.length > 0, 
                widgetBuilder: (context)=>Column(
                      children: [
                        if (state is UpdateCartLoadingState)
                          LinearProgressIndicator(
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(btnColor),
                          ),
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => cartBuilder(
                                model.data.cartItems[index], context),
                            separatorBuilder: (context, index) => Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey[200],
                            ),
                            itemCount: model.data.cartItems.length,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          color: Colors.grey[200],
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${appLang(context).subTotal}:  ',
                                style: black14().copyWith(color: Colors.black),
                              ),
                              Text(
                                '${model.data.subTotal.round()}${appLang(context).currency}',
                                style: black14().copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: 50,
                            child: MaterialButton(
                              child: Row(
                                children: [
                                  Text(
                                    '${appLang(context).proceedTo}',
                                    style: white16(),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                navigateTo(
                                    context: context, widget: CheckOutScreen());
                              },
                              color: btnColor,
                            ))
                      ],
                    ),
                 , fallbackBuilder: (context)=>Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image(
                            image: AssetImage('assets/images/emptystate.png'),
                          ),
                          // SizedBox(height: 20,),
                          Text(
                            '${appLang(context).emptyCart}',
                            style: black18(),
                          )
                        ],
                      ),
                    ),
                  
                   
                        
              
               fallbackBuilder: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),)

                  
                ),
             
        ));
      },
    ));


