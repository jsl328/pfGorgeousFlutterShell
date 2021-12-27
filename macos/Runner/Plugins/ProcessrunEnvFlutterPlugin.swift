//
//  ProcessrunEnvFlutterPlugin.swift
//  Runner
//
//  Created by jiangsl on 2021/12/27.
//

import Foundation
import FlutterMacOS
import AppKit


public class ProcessrunEnvFlutterPlugin: NSObject,FlutterMacOS.FlutterPlugin {

    //注册MethodChannel
   public static func register(with registrar: FlutterPluginRegistrar) {
      //flutter_plugin为约定的MethodChannel名称，flutter、android、ios三端一致即可
      let channel = FlutterMethodChannel(name: "processrun_env_flutter_plugin"
                                      , binaryMessenger: registrar.messenger)
      let instance = ProcessrunEnvFlutterPlugin()
      registrar.addMethodCallDelegate(instance, channel: channel)
   }
    
   //处理method，原始工程没有if-else，笔者增加
   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if("initEnvYaml"==call.method){
         //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
         //返回null
        // 获取脚本地址
//        let res =  CommandRunner.sync(command: path);
//        guard let path = Bundle.main.path(forResource: "EnvScript", ofType: "sh") else {
//                print("Unable to locate Script.command")
//                return
//        }
        let res =  CommandRunner.sync(command: "");
        //获取元组中分量的值
        print(res.0);
        print(res.1);
        result(res.1);
//         result(initEnvYaml());
    }else{//appsandoxAddress
         //没有找到method
         result(FlutterMethodNotImplemented)
      }
   }
    
    public func initEnvYaml() ->String{
        let taskQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background);
        var result: String = ""
        taskQueue.async {
            // 获取脚本地址
            guard let path = Bundle.main.path(forResource: "Script", ofType: "sh") else {
                    print("Unable to locate Script.command")
                    return
            }
            
            let buildTask = Process()
            
            buildTask.launchPath = path;
            // 传入参数
            buildTask.arguments = ["参数测试1", "参数测试2"];
            // 任务完成回调
            buildTask.terminationHandler = { task in
                DispatchQueue.main.async(execute: {
                    print("任务结束");
                    //result = task.standardOutput! as! String;
                });
            }
            // 开始执行任务
            buildTask.launch()
            // 等任务结束释放内存
            buildTask.waitUntilExit()
        }
        return result;
    }
}
