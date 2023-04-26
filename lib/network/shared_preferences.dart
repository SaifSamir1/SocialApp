



import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static late SharedPreferences sharedPreferences ;

  //كدا هنبدا نعرف ال متغير االلي عملته فوق
  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }


  static Future<bool> putData({
    required String key,
    required bool value
  }) async
  {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic gutData({ // عملناها هنا dynamic علشان اقدر ارجع اي نوع انا عايزه
    required String key,
  })
  {
    return sharedPreferences.get(key);
  }

  // دالة ال saveData نفس دالة ال putData بس
  // هنا عملتها لكل الانواع اللي ممكن اعملها حفظ وعلشان اعمل حفظ لازم key اقدر اوصل
  // للبيانات منه عند استدعائها و ال value دي القيمه اللي هيتم حفظها ف ال cache
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  })async
  {
    if(value is String) return await sharedPreferences.setString(key, value);
    if(value is int) return await sharedPreferences.setInt(key, value);
    if(value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async
  {
    return await sharedPreferences.remove(key);
  }
}