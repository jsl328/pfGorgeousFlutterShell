//
//  WhichFlutterShell.swift
//  Runner
//
//  Created by jiangsl on 2021/12/23.
//

import Foundation
import FlutterMacOS
import AppKit

public class ProcessrunFlutterShell: NSObject,FlutterMacOS.FlutterPlugin {
   //注册MethodChannel
   public static func register(with registrar: FlutterPluginRegistrar) {
      //flutter_plugin为约定的MethodChannel名称，flutter、android、ios三端一致即可
      let channel = FlutterMethodChannel(name: "processrun_flutter_plugin"
                                      , binaryMessenger: registrar.messenger)
      let instance = ProcessrunFlutterShell()
      registrar.addMethodCallDelegate(instance, channel: channel)
   }
   //处理method，原始工程没有if-else，笔者增加
   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      //getPlatformVersion、say为约定method，flutter、android、ios三端一致即可
      if("getPlatformVersion"==call.method){
//          let deviceName = Host.current().name
//          result("iOS " + UIDevice.current.systemVersion)
//          result(systemInfo());
          result("");
      }else if("say"==call.method){
           //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
           let map = call.arguments as? Dictionary<String,String>;
           let msg = map?["message"]
           result(msg)
           //返回null
           //result(nil)
      }else if("flutterBinBuild"==call.method){
          //传参方式调用原生，默认工程无此方法，通过Dictionary传参数
          let map = call.arguments as? Dictionary<String,String>;
          var msg:String = map?["message"] ?? "";
//          let utf8Command = "export LANG=en_US.UTF-8\n";
          msg.remove(at: msg.index(before: msg.endIndex))
          let res = flutterBinBuildSync(shellPath: msg, arguments: ["--version"]);
          result (res.1);
     }else{
         //没有找到method
         result(FlutterMethodNotImplemented)
      }
   }
    
    func flutterBinBuildSync(shellPath: String, arguments: [String]? = nil) -> (Int, String) {
        let task = Process()
        let pipe = Pipe()
        
//        var environment = ProcessInfo.processInfo.environment
//        environment["PATH"] = "/opt/anaconda3/bin:/opt/anaconda3/condabin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/bin:.:/Users/mac/Desktop/flutter/bin:/Users/mac/.gradle/wrapper/dists/gradle-5.1.1-all/bin:/usr/local/apache-tomcat-8.5.27/bin:/Library/Java/JavaVirtualMachines/jdk1.8.0_271.jdk/Contents/Home/bin:/Users/mac/Library/Android/sdk/tools:/Users/mac/Library/Android/sdk/platform-tools:/Users/mac/Library/Android/sdk/ndk/21.0.6113669:/Users/mac/Library/Android/sdk/ndk/21.0.6113669/ndk-build:/Users/mac/Desktop/apache-maven-3.5.3/bin"
//
////        environment["PATH"] = WhichFlutterShell().envCommand(commandPath: "echo $PATH");
//        task.environment = environment
        
        if arguments != nil {
            task.arguments = arguments!
        }
        
        task.launchPath = shellPath
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output: String = String(data: data, encoding: String.Encoding.utf8)!
        
        task.waitUntilExit()
        pipe.fileHandleForReading.closeFile()
        
        return (Int(task.terminationStatus), output)
    }

}
