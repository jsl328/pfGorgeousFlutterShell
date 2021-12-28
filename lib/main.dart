import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'ShellListView.dart';
import 'dart:core';
import 'package:flutter/foundation.dart';

void main() async {
  /*添加异常捕获*/
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // await myErrorsHandler.initialize();
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        // myErrorsHandler.onError(details);
        exit(1);
      };
      runApp(const MyApp());
    },
    (Object error, StackTrace stack) {
      // myErrorsHandler.onError(error, stack);
      exit(1);
    },
    zoneValues: {'ZoneName': 'Second zone'},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // late Future<List<ProcessResult>> _shellRes;

  void _incrementCounter() {
    //在pubspec.yaml里用的这个插件 process_run: ^0.12.2+2
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         '信息:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //       ShellListView(),
      //     ],
      //   ),
      // ),
      body: ShellListView(), //ListView组件
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: '测试',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
