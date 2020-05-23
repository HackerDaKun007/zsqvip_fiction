/**
 * @author      HackerDaKun007 <hackerdakun007@gmail.com>
 * @Remarks     无
 * @copyright   GPL
 * @since       1.0 version
 *
 *
 * @see         provider配置文件
*/
import 'package:provider/provider.dart'; //provider


//大坤配置_provider
import 'package:fiction/provider/readTime.dart'; //阅读时间

//Yuri_provider



final provider = [
  /**** 大坤配置_provider ****/
  ChangeNotifierProvider(builder: (_) => ReadTimeProvider()),

  /**** Yuri_provider ****/
];