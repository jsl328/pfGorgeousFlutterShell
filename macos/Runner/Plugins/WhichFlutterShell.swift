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
      }else if("lsShell"==call.method){
          //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
          //返回null
//          result(lsShell(commandPath: "/bin/ls",commandScript: ""));
          
          result(lsShell(commandPath: "/usr/bin/java",commandScript: "-version"));
     }else{
         //没有找到method
         result(FlutterMethodNotImplemented)
      }
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
                    let writer = FlutterStandardReaderWriter();
                    let codec = FlutterStandardMessageCodec(readerWriter: writer);
                    let codeData = codec.encode(task.standardOutput!);
                    // create codec
//                    FlutterStandardMessageCodec *codec = [FlutterStandardMessageCodec codecWithReaderWriter:[[FlutterStandardReaderWriter alloc] init]];
//                            // encode to binary
//                            NSData *binary = [codec encode:dict];
//                            // decode from binary
//                    let codec = FlutterMethodCodec.sharedInstance();
                    let dict = codec.decode(codeData);
//                            dict = codec decode:task.standardOutput];
//                            // print
                    print(dict);
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
