//
//  UnifiedRgistration.swift
//  Runner
//
//  Created by jiangsl on 2021/12/23.
//

import Foundation
import FlutterMacOS

class UnifiedRgistration{
    
    static func unifiedRegistration(registry: FlutterPluginRegistry){
        WhichFlutterShell.register(with: registry.registrar(forPlugin: "which_flutter_plugin"));
        ProcessrunFlutterShell.register(with: registry.registrar(forPlugin: "processrun_flutter_plugin"));
        AppsandoxFlutterPlugin.register(with: registry.registrar(forPlugin: "appsandox_flutter_plugin"));
    }
}


