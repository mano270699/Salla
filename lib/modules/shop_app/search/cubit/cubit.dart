import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/search_model.dart';
import 'package:salla/modules/shop_app/search/cubit/states.dart';
import 'package:salla/shared/components/costants.dart';
import 'package:salla/shared/network/end_point.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<ShopSearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel searchModel;
  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      path: SEARCH,
      token: token,
      data: {'text': text},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccsesState());
    }).catchError((err) {
      emit(SearchErrorState());
    });
  }
}
