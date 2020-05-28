/*
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         公共共享文件
*/
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class Common {

  /*
   * 验证数据是否存在, null 0 '' false 都返回false 
   */
  bool empty(var data) {
    print(data);
    if (data != null && data != 0 && data != '' && data != false) {
      data = data.trim(); //删除空格
      if (data != null && data != 0 && data != '' && data != false) {
        return true;
      }
    } 
    return false;
  }
  
  /*
   * 判断数组指定字符是否存在
   * @param {List} arr 数组(一维，二维)
   * @param {String} str 对比字符
   * @param {String} key 用于二维数组的键值
   * @return Bool 存在返回true, 否则返回false
   */
  bool inArray(List arr, String str, {String key}) {
    bool isBool = false;
    arr.forEach((value){
      if (key != null) {
        if (str == value[key]) {
          isBool = true;
          return;
        }
      } else {
        if (str == value) {
          isBool = true;
          return;
        }
      }
    });
    return isBool;
  }
  
  /*
   * 返回缓存图片
   * @param {String} images 网络图片地址
   * @param {int} type 传入: 1是高图 - 默认，2是宽图 - 大多用于轮播图等
   * @return dynamic 图片信息
   */
  dynamic cacheImages(String images, {int type=1}) {
    return CachedNetworkImage(
      placeholder: (context, url) => Image.asset('images/preload-$type.jpg'),
      imageUrl: images,
      errorWidget: (context, url, error) => Image.asset('images/preload-error-$type.jpg'),
    );
  }

}