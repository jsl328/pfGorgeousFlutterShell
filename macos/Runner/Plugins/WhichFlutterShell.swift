//
//  WhichFlutterShell.swift
//  Runner
//
//  Created by jiangsl on 2021/12/23.
//

import Foundation
//import Flutter
import FlutterMacOS
//import UIKit
import AppKit

public class WhichFlutterShell: NSObject,FlutterMacOS.FlutterPlugin {

    //注册MethodChannel
   public static func register(with registrar: FlutterPluginRegistrar) {
      //flutter_plugin为约定的MethodChannel名称，flutter、android、ios三端一致即可
      let channel = FlutterMethodChannel(name: "which_flutter_plugin"
                                      , binaryMessenger: registrar.messenger)
      let instance = WhichFlutterShell()
      registrar.addMethodCallDelegate(instance, channel: channel)
   }
    
   //处理method，原始工程没有if-else，笔者增加
   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      //getPlatformVersion、say为约定method，flutter、android、ios三端一致即可
      if("getPlatformVersion"==call.method){
//          result("iOS " + UIDevice.current.systemVersion)
          result(systemInfo());
      }else if("say"==call.method){
           //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
           let map = call.arguments as? Dictionary<String,String>;
           let msg = map?["message"]
           result(msg)
           //返回null
           //result(nil)
      }else if("whichls"==call.method){
          //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
          //返回null
//          result(lsShell(commandPath: "/bin/ls",commandScript: ""));
          result(lsShell(commandPath: "ls",commandScript: "-la"));//
     }else if("whichflutter"==call.method){
         //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
         //返回null
//          result(lsShell(commandPath: "/bin/ls",commandScript: ""));
         result(grepWhichCommand(path: "Users/mac/Desktop/flutter/bin/flutter" , commandPath:"flutter"));
    }else if("appsandox_home"==call.method){
         //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
         //返回null
         result(lsShell(commandPath: "",commandScript: "la"));
    }else{//appsandoxAddress
         //没有找到method
         result(FlutterMethodNotImplemented)
      }
   }
    func envCommand(commandPath:String) ->String{
        let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background);
        var grepWhichResult: String = ""
        taskQueue.async {
            let buildTask = Process()
            let pipe = Pipe();
            /*
             shell("/bin/bash", arguments: ["-c", "'/Applications/Xamarin Studio.app/Contents/MacOS/mdtool' -v build '--configuration:Beta|iPhone' MyApp.iOS.sln"])
             */
            buildTask.launchPath = commandPath;
            // 传入参数
            buildTask.arguments = ["-c"];
            // 任务完成回调
//            buildTask.terminationHandler = { task in
//                DispatchQueue.main.async(execute: {
//                    print("任务结束");
////                    grepWhichResult = task.standardOutput!;
//                });
//            }
            buildTask.standardOutput = pipe
            // 开始执行任务
            buildTask.launch()
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let output: String = String(data: data, encoding: String.Encoding.utf8)!
            // 等任务结束释放内存
            buildTask.waitUntilExit()
            pipe.fileHandleForReading.closeFile()
            //return (Int(task.terminationStatus), output)
            grepWhichResult = output;
        }
         return grepWhichResult;
    }
    func grepWhichCommand(path: String, commandPath:String) ->String{
        let task = Process()
        let pipe = Pipe()
        
        var environment = ProcessInfo.processInfo.environment
        environment["PATH"] = "/opt/anaconda3/bin:/opt/anaconda3/condabin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/bin:.:/Users/mac/Desktop/flutter/bin:/Users/mac/.gradle/wrapper/dists/gradle-5.1.1-all/bin:/usr/local/apache-tomcat-8.5.27/bin:/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/bin:/Users/mac/Library/Android/sdk/tools:/Users/mac/Library/Android/sdk/platform-tools:/Users/mac/Library/Android/sdk/ndk/21.0.6113669:/Users/mac/Library/Android/sdk/ndk/21.0.6113669/ndk-build:/Users/mac/Desktop/apache-maven-3.5.3/bin"
        
//        environment["PATH"] = WhichFlutterShell().envCommand(commandPath: "echo $PATH");
        task.environment = environment
        
        task.arguments = [commandPath]
        
        task.launchPath = path
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = String(data: data, encoding: String.Encoding.utf8)!
        
        task.waitUntilExit()
        pipe.fileHandleForReading.closeFile()
        print(output);
//        return (Int(task.terminationStatus), output)
//        let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background);
        var grepWhichResult: String = ""
//        taskQueue.async {
//            let buildTask = Process()
////            buildTask.launchPath = "/usr/bin/which"
//            buildTask.launchPath = path;
//            // 传入参数
//            buildTask.arguments = [commandPath];
//            // 任务完成回调
//            buildTask.terminationHandler = { task in
//                DispatchQueue.main.async(execute: {
//                    print("任务结束");
////                    grepWhichResult = task.standardOutput!;
//                });
//            }
//            // 开始执行任务
//            buildTask.launch()
//            // 等任务结束释放内存
//            buildTask.waitUntilExit()
//        }
        return grepWhichResult;
    }
    
    func lsShell(commandPath :String , commandScript:String) ->String{
        let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background);
        var res: String = ""
        taskQueue.async {
            
            // 获取脚本地址
//            guard let path = Bundle.main.path(forResource: "script", ofType: "command") else {
//                print("Unable to locate script.command")
//                return
//            }
            // 初始化任务
            let buildTask = Process()
            buildTask.launchPath = commandPath
            // 传入参数
            buildTask.arguments = [commandScript]
            // 任务完成回调
            buildTask.terminationHandler = { task in
                DispatchQueue.main.async(execute: {
                    print("任务结束")
//                    let xx = task.standardOutput!;
//                    for (key, value) in xx  ??  [AnyHashable: Any]() {
//                                print(key,type(of: value))
//                            }
//                            for value in xx ?? [Any]() {
//                                print(type(of: value))
//                            }
            
//                    let sss:String=String.init(format:"ddd%tu",task.standardOutput!)
//                    return task.standardOutput;
//                    res = task.standardOutput! as! String
//                    let writer = FlutterStandardReaderWriter();
//                    let codec = FlutterStandardMessageCodec(readerWriter: writer);
//                    let codeData = codec.encode(task.standardOutput!);
                    // create codec
//                    FlutterStandardMessageCodec *codec = [FlutterStandardMessageCodec codecWithReaderWriter:[[FlutterStandardReaderWriter alloc] init]];
//                            // encode to binary
//                            NSData *binary = [codec encode:dict];
//                            // decode from binary
//                    let codec = FlutterMethodCodec.sharedInstance();
//                    let dict = codec.decode(codeData);
//                            dict = codec decode:task.standardOutput];
//                            // print
//                    print(dict);
//                            NSLog(@"Decoded value: %@", dict);
//                    codec
//
                })
            }
            // 开始执行任务
            buildTask.launch()
            // 等任务结束释放内存
            buildTask.waitUntilExit()
        }
        return res;
    }
    func systemInfo() -> String {
        let process = ProcessInfo();
        return String(process.operatingSystemVersion.majorVersion);
    }
}
