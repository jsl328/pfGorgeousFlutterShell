/*

  classs: WhichFlutterPlugin
  description: 原生WhichFlutterPlugin的插件方法
  author : jiangsl
  date: 22/12 2021

*/
import 'dart:async';

import 'package:flutter/services.dart';

class WhichFlutterPlugin {
  //通过字符串which_flutter_plugin找到约定的MethodChannel
  static const MethodChannel _channel = MethodChannel('which_flutter_plugin');

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
    print("object----$version");
    return version;
  }

  static Future<String> get whichls async {
    //需要使用async、await标记异步调用
    //lsShell为自定义原生方法名称
    final String lsout = await _channel.invokeMethod('whichls');
    return lsout;
  }

  static Future<String> get whichflutter async {
    //需要使用async、await标记异步调用
    //lsShell为自定义原生方法名称
    final String whichFlutterOut = await _channel.invokeMethod('whichflutter');
    return whichFlutterOut;
  }
}
