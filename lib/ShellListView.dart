import 'dart:io';

import 'package:flutter/material.dart';
import 'GrepCommand.dart';
import 'ProcessResultEntity.dart';
import 'ShellScript.dart';

class ShellListView extends StatefulWidget {
  @override
  _ListViewState createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State<ShellListView> {
  List<ProcessResultEntity> _items = [];
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
    which dart, flutter ,ls ,java
    in my local env ,which dart = /usr/local/flutter/bin/dart;
    which flutter = /usr/local/flutter/bin/flutter,
    which ls = /bin/ls
    which java = /usr/bin/java

    execute shell.run('/usr/local/flutter/bin/dart  --version')
    Dart SDK version: 2.16.0-85.0.dev (dev) (Mon Dec 6 21:50:02 2021 -0800) on "macos_x64"
    
    execute shell.run('/usr/local/flutter/bin/flutter') 
    in addtional , show flutter help commmits
    
    execute shell.run('ls')
    list current login user`s  workspaces

    execute shell.run('/usr/bin/java -version')
    stdout java version "1.8.0_271"
    Java(TM) SE Runtime Environment (build 1.8.0_271-b09)
    Java HotSpot(TM) 64-Bit Server VM (build 25.271-b09, mixed mode)
    but '/usr/bin/java -version' have more bugs 
  */

  void _listViewResponse() async {
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
    // var commandPath = "dart";
    // var dartRun = GrepCommand.grepSyncRunShellCommandPath(commandPath);
    // Future<List<ProcessResult>> _shellRes =
    //     ShellScriptStatic.dartVersionShellCommand('${dartRun!}  --version')!;
    // _shellRes.then((out) {
    //   Iterable<ProcessResultEntity> pentity = out.map((ProcessResult item) {
    //     return generateProcessResultEntity(item);
    //   });
    //   setState(() {
    //     _items.addAll(pentity);
    //   });
    // });

    // var dartRun = GrepCommand.grepSyncRunShellCommandPath(commandPath);
    // Future<ProcessResult> _shellCmdRes =
    //     ShellScriptStatic.startCmdShellCommand('${dartRun!}  --version')!;
    // _shellCmdRes.then((out) {
    //   // var sm = ProcessResultEntity();
    //   setState(() {
    //     _items.add(generateProcessResultEntity(out));
    //   });
    // });
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

    var lsCommandPath = "ls";
    var lsRun = await GrepCommand.grepRunShellCommandPath(lsCommandPath);
    Future<List<ProcessResult>> _lsShellRes =
        ShellScriptStatic.startShellCommand(lsRun!.grepRes.toString())!;
    _lsShellRes.then((out) {
      Iterable<ProcessResultEntity> lsEntity = out.map((ProcessResult item) {
        return generateProcessResultEntity(item);
      });
      setState(() {
        _items.addAll(lsEntity);
      });
    });

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

    /*
      await run('flutter build');
      await run('dart --version');
      await run('''
      dart --version
      git status
      ''');
    */
  }

  @override
  void initState() {
    print('initState');
    // TODO: implement initState
    super.initState();
  }

  void _incrementShellTask() async {
    _items = [];
    _listViewResponse();
  }

  //buildListTile相当于ListView的Adapter
  Widget buildListTile(BuildContext context, ProcessResultEntity item) {
    return ListTile(
      isThreeLine: true, //子item的是否为三行
      dense: false,
      leading: CircleAvatar(
        child: Text(item.pid.toString()),
      ), //左侧首字母图标显示，不显示则传null
      title: Text(item.exitCode.toString()), //子item的标题
      subtitle: Text(item.stdout + 'multi:' + item.stderr), //子item的内容
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
        title: const Text("ListView"),
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
