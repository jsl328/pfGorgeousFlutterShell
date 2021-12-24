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

public class AppsandoxFlutterPlugin: NSObject,FlutterMacOS.FlutterPlugin {

    //注册MethodChannel
   public static func register(with registrar: FlutterPluginRegistrar) {
      //flutter_plugin为约定的MethodChannel名称，flutter、android、ios三端一致即可
      let channel = FlutterMethodChannel(name: "appsandox_flutter_plugin"
                                      , binaryMessenger: registrar.messenger)
      let instance = AppsandoxFlutterPlugin()
      registrar.addMethodCallDelegate(instance, channel: channel)
   }
    
   //处理method，原始工程没有if-else，笔者增加
   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      if("appsandoxhome"==call.method){
          result(NSHomeDirectory());
      }else{
         //没有找到method
         result(FlutterMethodNotImplemented)
      }
   }
}
