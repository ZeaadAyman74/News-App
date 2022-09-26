import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';
import 'cubit_observer.dart';
//https://newsapi.org/v2/top-headlines?

void main() async {
  // دي عشان تتاكد ان كل حاجة هنا في الميثود خلصت و بعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
 await CacheHelper.init();

  bool? isDark;
  isDark=CacheHelper.getData(key: 'isDark');

  BlocOverrides.runZoned(
        () => runApp( MyApp(isDark)),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
    bool? isDark;
     MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewsCubit()..getBusiness()..changeMode(fromShared:isDark ),
    child: BlocConsumer<NewsCubit, NewsStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        home: Directionality(
          textDirection:TextDirection.ltr ,
          child: AnimatedSplashScreen(
            nextScreen: NewsLayout(),
            splash: Image.asset('assets/images/news.png'),
            animationDuration: const Duration(milliseconds: 1900),
            duration: 2500,
            backgroundColor: Colors.white,
            centered: true,
             splashTransition: SplashTransition.decoratedBoxTransition,
            pageTransitionType: PageTransitionType.fade,
            splashIconSize: 150,

          ),
        ),

      );
    },
    ),
    );
  }
}

