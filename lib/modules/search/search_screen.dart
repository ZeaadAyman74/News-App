import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

var searchController = TextEditingController(); // لو دلخلتها جوا الكلاس الكلام اللي في ال search بيتمسح كل مرة ال state بتتغير ////////////

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  InputBorder inputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)));

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFFBFBFD),
                      hintText: "Search items",
                      hintStyle: const TextStyle(fontSize: 20),
                      focusedBorder: inputBorder,
                      enabledBorder: inputBorder,
                      border: inputBorder,
                      errorBorder: inputBorder,
                      prefixIcon:const IconTheme(data: IconThemeData(
                        color: Colors.grey,size: 30
                      ),
                        child: Icon(Icons.search),
                      )
                      //SvgPicture.asset('assets/icons/Search.svg'),
                    ),
                    keyboardType: TextInputType.text,
                    controller:searchController ,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value){
                      cubit.searchData(value);
                    },
                  ),

                  // child: defaultFormField(
                  //     myController: searchController,
                  //     type: TextInputType.text,
                  //     validate: (String? value){
                  //             if(value!.isEmpty) {return 'Cannot be empty';}
                  //                    else {return null;}
                  //     },
                  //    hint:"Search",
                  //     prefix:Icons.search,
                  //     onSubmit: (value){
                  //       cubit.searchData(value);
                  //     }
                  // ),
                ),
                Expanded(child: buildArticle(cubit.search)),
              ],
            ),
          ),
        );
      },
    );
  }
}
