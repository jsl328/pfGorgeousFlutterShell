// classs: GlobalEnvPath
// description: 环境变量设置,需要根据不同平台适配后填入
// author : jiangsl
// date: 28/12 2021
import 'dart:io';

class GlobalEnvPath {
  static systembin() {
    if (Platform.isMacOS) {
      return '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin';
    }
    return '';
  }

  static flutterbin() {
    if (Platform.isMacOS) {
      return '/Users/mac/Desktop/flutter/bin'; //这里需要手动指定
    }
    return '';
  }
}
