import 'dart:async';

import 'package:flutter/services.dart';

class Appsandox {
  //通过字符串appsandox_flutter_plugin找到约定的MethodChannel
  static const MethodChannel _channel =
      MethodChannel('appsandox_flutter_plugin');

  static Future<String> get appsandoxAddress async {
    //需要使用async、await标记异步调用
    //lsShell为自定义原生方法名称
    final String appsandox = await _channel.invokeMethod('appsandoxhome');
    return appsandox;
  }
}
