import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import '../../modules/business/buisness_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  List<Widget> taps = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen(),
  ];

  int currentIndex = 0;

  void changeTap(int index) {
    switch (index) {
      case 1:
        {
          getScience();
          break;
        }
      case 2:
        {
          getSports();
          break;
        }
    }
    currentIndex = index;
    emit(ChangeTapState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search=[];

  void getBusiness() {
    if (business.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '1b065b3a220f4c54b95ed3bfe410c059',
      }).then((value) {
        business = value.data['articles'];
        emit(GetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        GetBusinessErrorState(error.toString());
      });
    }
  }

  void getSports() {
    if (sports.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '1b065b3a220f4c54b95ed3bfe410c059',
      }).then((value) {
        sports = value.data['articles'];
        emit(GetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        GetSportsErrorState(error.toString());
      });
    }
  }

  void getScience() {
    if (science.isEmpty) {
      DioHelper.getData(path: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '1b065b3a220f4c54b95ed3bfe410c059',
      }).then((value) {
        science = value.data['articles'];
        emit(GetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        GetScienceErrorState(error.toString());
      });
    }
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark=fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  void searchData(String controller){

    DioHelper.getData(
        path: 'v2/everything',
        query: {
          'q': controller,
          'apiKey': '1b065b3a220f4c54b95ed3bfe410c059'
        }
    ).then((value) {
      search=value.data['articles'];
      emit(GetSearchState(controller));
    }).catchError((error){
    emit(GetSearchErrorState());
    });
  }
}
