// classs: ShellListView
// description: 使用一个Listview来展示shell命令的结果集
// author : jiangsl
// date: 23/12 2021
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:pf/Appsandox.dart';
// import 'package:pf/ProcessrunEnv.dart';
// import 'package:pf/ProcessrunFlutterPlugin.dart';
import 'GrepCommand.dart';
import 'ProcessResultEntity.dart';
import 'ShellScript.dart';
// import 'whichFlutterPlugin.dart';
// import 'package:process_run/which.dart';

class ShellListView extends StatefulWidget {
  @override
  _ListViewState createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State<ShellListView> {
  List<ProcessResultEntity> _items = [];
  String appsandox = "";
  /*
    使用ProcessResult构建ProcessResultEntity实体
  */
  ProcessResultEntity generateProcessResultEntity(ProcessResult result) {
    var processRes = ProcessResultEntity();
    processRes.pid = result.pid;
    processRes.phashCode = result.hashCode;
    processRes.exitCode = result.exitCode;
    processRes.stdout = result.stdout;
    processRes.stderr = result.stderr;
    return processRes;
  }

  /*
    初始化listview的数据集
  */
  void _listViewResponse() async {
    /* dart  --version 实现*/
    var commandPath = "dart";
    var dartRun = await GrepCommand.grepRunShellCommandPath(commandPath);
    Future<List<ProcessResult>> _shellRes =
        ShellScriptStatic.dartVersionShellCommand(
            '${dartRun!.grepRes}  --version')!;
    _shellRes.then((out) {
      Iterable<ProcessResultEntity> pentity = out.map((ProcessResult item) {
        return generateProcessResultEntity(item);
      });
      setState(() {
        _items.addAll(pentity);
      });
    });

    /* flutter  --build 实现*/
    var fluttercommandPath = "flutter";
    var flutterRun =
        await GrepCommand.grepRunShellCommandPath(fluttercommandPath);
    Future<List<ProcessResult>> _flutterShellRes =
        ShellScriptStatic.startShellCommand('${flutterRun!.grepRes}  build')!;
    _flutterShellRes.then((out) {
      Iterable<ProcessResultEntity> flutterEntity =
          out.map((ProcessResult item) {
        return generateProcessResultEntity(item);
      });
      setState(() {
        _items.addAll(flutterEntity);
      });
    });
    /* ls  实现*/
    var lsCommandPath = "ls";
    var lsRun = await GrepCommand.grepRunShellCommandPath(lsCommandPath);
    Future<List<ProcessResult>> _lsShellRes =
        ShellScriptStatic.startShellCommand('${lsRun!.grepRes} -la')!;
    _lsShellRes.then((out) {
      Iterable<ProcessResultEntity> lsEntity = out.map((ProcessResult item) {
        return generateProcessResultEntity(item);
      });
      setState(() {
        _items.addAll(lsEntity);
      });
    });
    /* pwd  实现*/
    var pwdCommandPath = "pwd";
    var pwdRun = await GrepCommand.grepRunShellCommandPath(pwdCommandPath);
    Future<List<ProcessResult>> _pwdShellRes =
        ShellScriptStatic.startShellCommand(pwdRun!.grepRes)!;
    _pwdShellRes.then((out) {
      Iterable<ProcessResultEntity> pwdEntity = out.map((ProcessResult item) {
        return generateProcessResultEntity(item);
      });
      setState(() {
        _items.addAll(pwdEntity);
      });
    });
    /* java -version  实现*/
    var javaSDKCommandPath = "java";
    var javaSDKRun =
        await GrepCommand.grepRunShellCommandPath(javaSDKCommandPath);
    Future<List<ProcessResult>> _javaSDKShellRes =
        ShellScriptStatic.startShellCommand('${javaSDKRun!.grepRes} -version')!;
    _javaSDKShellRes.then((out) {
      Iterable<ProcessResultEntity> javaSDKEntity =
          out.map((ProcessResult item) {
        return generateProcessResultEntity(item);
      });
      setState(() {
        _items.addAll(javaSDKEntity);
      });
    });
    /* flutter pub --version  实现*/
    var flutterPubCommandPath = "flutter";
    var flutterPubRun =
        await GrepCommand.grepRunShellCommandPath(flutterPubCommandPath);
    if (flutterPubRun!.grepRes.isNotEmpty) {
      Future<List<ProcessResult>> _flutterPubShellRes =
          ShellScriptStatic.startShellCommand(
              '${flutterPubRun.grepRes} pub --version')!;
      _flutterPubShellRes.then((out) {
        Iterable<ProcessResultEntity> flutterPubResEntity =
            out.map((ProcessResult item) {
          return generateProcessResultEntity(item);
        });
        setState(() {
          _items.addAll(flutterPubResEntity);
        });
      });
    } else {
      print(flutterPubRun.grepRes);
    }
  }

  /*原生桥接插件，用户获取应用的工作目录*/
  void getAppsandox() async {
    // Appsandox.appsandoxAddress.then((value) {
    //   print('object------$value');
    //   setState(() {
    //     appsandox = value;
    //   });
    // });
  }

  @override
  void initState() {
    print('initState');
    super.initState();
    /*flutter的工作目录，同步获取作为应用的标题,同步异常捕获使用*/
    try {
      String flutterExecutable =
          GrepCommand.grepSyncRunShellCommandPath("flutter")!;
      setState(() {
        appsandox = flutterExecutable;
      });
      //print('Allocate something 3');
      //throw 'Other error occurred';
    } on UnsupportedError {
      print('Cant divide to zero');
    } on FormatException catch (e) {
      print('Format exceptions: $e');
    } catch (e, s) {
      print('Unknown exceptions: $e, with stack: \n$s');
      rethrow;
    } finally {
      print('Clean-up something 3');
    }
    // try {
    //   Future.delayed(Duration(seconds: 1), () {
    //     final _ = 100 ~/ 0;
    //   });
    //   print('Everything is fine!');
    // } on UnsupportedError {
    //   print('Cant divide to zero');
    // } finally {
    //   print('Clean-up done');
    // }
  }

  void _incrementShellTask() async {
    _items = []; //清空listview数据集
    _listViewResponse();
    getAppsandox();
  }

  //buildListTile相当于ListView的Adapter
  Widget buildListTile(BuildContext context, ProcessResultEntity item) {
    return ListTile(
      isThreeLine: true, //子item的是否为三行
      dense: false,
      leading: CircleAvatar(
        child: Text(item.pid.toString()), //header显示shell.run的线程pid
      ), //左侧首字母图标显示，不显示则传null
      title: Text(item.exitCode.toString()), //大标题显示shell.run的exitCode码，0是成功返回
      subtitle: Text(item.stdout.isNotEmpty
          ? item.stdout
          : item.stderr), //小标题的内容显示shell.run的返回信息
      // trailing: const Icon(
      //   Icons.arrow_right,
      //   color: Colors.green,
      // ), //显示右侧的箭头，不显示则传null
      trailing: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    Iterable<Widget> listTitles = _items.map((ProcessResultEntity item) {
      //将items的内容设置给Adapter
      return buildListTile(context, item);
    });
    listTitles = ListTile.divideTiles(
        context: context, tiles: listTitles); //给Listview设置分隔线
    return Scaffold(
      appBar: AppBar(
        title: Text(appsandox),
      ),
      body: Scrollbar(
          child: ListView(
        children: listTitles.toList(), //添加ListView控件
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementShellTask,
        tooltip: '测试',
        child: const Icon(Icons.add),
      ),
    );
  }
}
