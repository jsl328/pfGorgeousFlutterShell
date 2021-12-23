/*

  classs: ShellScriptStatic
  description: 各类shell.run()的静态方法
  author : jiangsl
  date: 22/12 2021

*/
import 'dart:io';
import 'package:process_run/cmd_run.dart';
import 'package:process_run/shell.dart';
import 'dart:core';

class ShellScriptStatic {
  /*
    startPath:shell.run()的第一个参数
    description:shell.run()调用方法
    return :Future<List<ProcessResult>>? 类型
  */
  static Future<List<ProcessResult>>? startShellCommand(String startPath) {
    late Future<List<ProcessResult>> result;
    if (startPath.isEmpty) {
      print("script不能我空");
      return null;
    } else {
      var dartVersionShell = Shell();
      result = dartVersionShell.run(startPath);
    }
    return result;
  }

  /*
  
    startPath:shell.run()的第一个参数
    description:shell.run()调用方法,unuse,移步startShellCommand()
    return :Future<List<ProcessResult>>? 类型

  */
  static Future<List<ProcessResult>>? dartVersionShellCommand(String path) {
    late Future<List<ProcessResult>> result;
    if (path.isEmpty) {
      print("script不能我空");
      return null;
    } else {
      var dartVersionShell = Shell();
      result = dartVersionShell.run(path);
    }
    return result;
  }

  static Future<ProcessResult>? startCmdShellCommand(String cmd) {
    var process = ProcessCmd(cmd, []);
    return runCmd(process);
  }

  static void pubVersionShellCommand(String path) {
    if (path.length == 0) {
      print("script不能我空");
    } else {
      var pubVersionShell = Shell();
      pubVersionShell.run(path);
    }
    return;
  }

  static void flutterVersionShellCommand(String path) {
    if (path.length == 0) {
      print("script不能我空");
    } else {
      var flutterVersionShell = Shell();
      flutterVersionShell.run(path);
    }
  }

  static void javaVersionShellCommand(String path) {
    if (path.length == 0) {
      print("script不能我空");
    } else {
      var javaVersionShell = Shell();
      javaVersionShell.run(path);
    }
  }

  static void lsShellCommand(String path) {
    if (path.length == 0) {
      print("script不能我空");
    } else {
      var lsShell = Shell();
      lsShell.run(path);
    }
    return;
  }

  static void workSpaceShellCommand(String path) {
    if (path.length == 0) {
      print("script不能我空");
    } else {
      var wpShell = Shell();
      wpShell.run(path);
    }
  }
}
