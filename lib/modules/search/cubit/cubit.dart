import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';
import 'package:shop_app/shared/constant.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel ;

  void search({
    required String text ,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data:
      {
        'text':text,
      },
      token: token ,
    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState()) ;
    }).catchError((error)
    {
      //print(error.toString()) ;
      emit(SearchErrorState(error.toString()),);
    });
  }
}