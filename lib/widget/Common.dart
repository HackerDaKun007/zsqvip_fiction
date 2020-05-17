/**
 * @author      dakun007 <dakun007@hotmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         公共共享文件
*/

class Common {

  //验证数据是否存在
  isValidate(var data) {
    if (data != null) {
      return data;
    } else {
      return false;
    }
  }
  
  /**
   * 判断数组指定字符是否存在
   * @param {List} 数组
   * @param {String} 字符
   * @return Bool 存在返回true, 否则返回false
   */
  in_array(List arr, String str) {
    bool isBool = false;
    arr.forEach((value){
      if (str == value) {
        isBool = true;
        return;
      }
    });
    return isBool;
  }
  

}