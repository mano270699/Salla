import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/modules/shop_app/search/cubit/cubit.dart';
import 'package:salla/modules/shop_app/search/cubit/states.dart';
import 'package:salla/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  //const SearchScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var SearchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, ShopSearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormText(
                        controller: SearchTextController,
                        type: TextInputType.text,
                        lable: 'search',
                        prefixIcon: Icons.search,
                        onSubmit: (value) {
                          SearchCubit.get(context).search(value);
                        },
                        validate: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your any text';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccsesState)
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildProductItem(
                                SearchCubit.get(context)
                                    .searchModel
                                    .data
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => MyDiver(),
                            itemCount: SearchCubit.get(context)
                                .searchModel
                                .data
                                .data
                                .length),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
