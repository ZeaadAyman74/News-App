import 'package:flutter/material.dart';
import 'package:news_app/modules/webview/webview_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required String txt,
  required Function() function,
  double radius = 0.0,
}) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? txt.toUpperCase() : txt,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController myController,
  required TextInputType type,
  required String? Function(String? value) validate,
  required IconData prefix,
  String? label,
  String? hint,
  Function(String value)? onSubmit,
  Function(String value)? onChange,
  IconData? sufix,
  Function()? sufixPress,
  bool isPassword = false,
  void Function()? onTap,
}) =>
    TextFormField(
      controller: myController,
      keyboardType: type,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
          icon: Icon(sufix),
          onPressed: sufixPress,
        ),
        border:  OutlineInputBorder(borderRadius:BorderRadius.circular(40)),
      ),
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
    );

Widget buildArticleItem(map, context) => GestureDetector(
  onTap: (){
    Navigator.push(context,MaterialPageRoute(builder: (context)=>WebViewScreen(map['url'])));
  },
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(map['urlToImage'] ??
                        'https://th.bing.com/th/id/OIP.rPDuoJgIPkGu-9TSDDLfjgHaHa?pid=ImgDet&w=600&h=600&rs=1'),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${map['title']} ',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${map['publishedAt']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget buildArticle(list) => ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
        child: Container(
          height: 1,
          color: Colors.grey,
          width: double.infinity,
        ),
      ),
      itemCount: list.length,
    );
