/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com> 
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         本地存储库
*/
import 'package:shared_preferences/shared_preferences.dart';

class Storage{

  //存储字符
  static Future<void> setString(key,value) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setString(key, value);
  }

  //获取字符
  static Future<String> getString(key) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getString(key);
  }

  //删除本地指定数据
  static Future<void> remove(key) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    data.remove(key);
  }


  //存储数字
  static Future<void> setInt(key,value) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setInt(key, value);
  }

  //获取数字
  static Future<int> getInt(key) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getInt(key);
  }

  //存储一维数组
  static Future<void> setList(key,value) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    data.setStringList(key, value);
  }

  //获取一维数组
  static Future<List> getList(key) async{
    SharedPreferences data = await SharedPreferences.getInstance();
    return data.getStringList(key);
  }

}