/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         公共共享文件
*/

class Common {

  /*
   * 验证数据是否存在, null 0 '' false 都返回false 
   */
  empty(var data) {
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
   * @param {List} 数组
   * @param {String} 字符
   * @return Bool 存在返回true, 否则返回false
   */
  inArray(List arr, String str) {
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