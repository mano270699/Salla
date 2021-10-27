import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/single_cat_model.dart';
import 'package:salla/modules/shop_app/single_category/bloc/states.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/end_point.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class SingleCatCubit extends Cubit<SingleCatStates> {
  SingleCatCubit() : super(SingleCatStateInit());
  static SingleCatCubit get(context) => BlocProvider.of(context);

  SingleCatModel singleCatModel;
  getSingleCategory(int id, context) {
    emit(SingleCatStateLoading());
    return DioHelper.getData(
            path: SINGLE_CATEGORY_POINT,
            query: {'category_id': id},
            token: token)
        .then((value) {
      singleCatModel = SingleCatModel.fromJson(value.data);
      print(singleCatModel.data.data[1].name);
      emit(SingleCatStateSuccess());
    }).catchError((error) {
      emit(SingleCatStateError(error));
    });
  }
}
