// classs: GrepCommand
// description: which()调用的静态方法
// author : jiangsl
// date: 22/12 2021

import 'dart:io';

import 'package:pf/GlobalEnvPath.dart';

import 'GrepEntity.dart';
import 'package:process_run/shell.dart';

class GrepCommand {
  /*
  commandPath:需要查找的shell命令所在路径,比如'ls'= /bin/ls
  action: grepRunShellCommandPath
  description: which()调用的静态方法
  */
  static Future<GrepEntity?> grepRunShellCommandPath(String commandPath) async {
    var grepEntityInstance = GrepEntity();
    if (commandPath.isEmpty) {
      //print("value为空");
      grepEntityInstance.status = 404;
      grepEntityInstance.grepName = commandPath;
      grepEntityInstance.grepRes = "commandScript 为空";
    }
    grepEntityInstance.grepName = commandPath;
    Future<String?> newWhich = Future(() => null);
    //异步方法
    newWhich = which(commandPath,
        environment: {"PATH": GlobalEnvPath.flutterbin()},
        includeParentEnvironment: true);
    newWhich
        .then((value) => {
              // print("object----$value"),
              grepEntityInstance.status = 200,
              grepEntityInstance.grepRes = value.toString()
            })
        .catchError((_) {
      //print("本机whic路径未找到");
      grepEntityInstance.status = 401;
      grepEntityInstance.grepRes = "本机whic路径未找到";
    });
    return grepEntityInstance;
  }

  static String? grepSyncRunShellCommandPath(String commandPath) {
    if (commandPath.isEmpty) {
      return 'commandPath 为空';
    } else {
      return whichSync(commandPath,
          environment: {"PATH": GlobalEnvPath.flutterbin()},
          includeParentEnvironment: true); //同步返回
    }
  }
}
