import 'dart:async';

import 'package:flutter/services.dart';

class ProcessrunFlutterPlugin {
  //通过字符串which_flutter_plugin找到约定的MethodChannel
  static const MethodChannel _channel =
      const MethodChannel('processrun_flutter_plugin');

  /*
   *传参方式调用原生，默认工程无此方法 
   */
  static Future<String> get say async {
    //需要使用async、await标记异步调用，say为自定义原生方法名称
    //<String, dynamic>{'message': "Flutter arguments"}通过key-value方式传参数
    final String res = await _channel
        .invokeMethod("say", <String, dynamic>{'message': "Flutter arguments"});
    return res;
  }

  static Future<String> get platformVersion async {
    //需要使用async、await标记异步调用
    //getPlatformVersion为自定义原生方法名称
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
