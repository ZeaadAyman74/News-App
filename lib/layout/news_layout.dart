import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.minWidth.toStringAsFixed(2));
        print(constraints.maxWidth.toStringAsFixed(2));
        return BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: const Text("News App"),
                actions: [
                  IconButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                  }, icon: const Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        cubit.changeMode();
                      },
                      icon: const Icon(Icons.brightness_4_outlined))
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeTap(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.business), label: "Business"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.science), label: "Science"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.sports), label: "Sports"),
                ],
              ),
              body: cubit.taps[cubit.currentIndex],
            );
          },
        );
      },
    );
  }
}
