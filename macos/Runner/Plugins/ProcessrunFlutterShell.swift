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
      }else{
         //没有找到method
         result(FlutterMethodNotImplemented)
      }
   }

}
