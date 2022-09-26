import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static late SharedPreferences sharedPref ;

  static Future init()async{
   sharedPref=await SharedPreferences.getInstance();
  }

  static Future putData({required String key,required var value})async{
   await sharedPref.setBool(key, value); // (sharedPreference) بيعمل save في الكاش ميموري بتاعت الابليكيشن //
  }
  static bool? getData({required String key}){
    return sharedPref.getBool(key);
  }
}