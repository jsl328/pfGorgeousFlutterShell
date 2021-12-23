import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
//    func registrar(forPlugin pluginKey: String) -> FlutterPluginRegistrar {
//        <#code#>
//    }
//
//    func registrar(forPlugin pluginKey: String) -> FlutterPluginRegistrar {
//        <#code#>
//    }
//    
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
//      RegisterGeneratedPlugins(registry: self);
      //注册我们自己的控件
//      UnifiedRgistration.registerWith(registry:  self);
    return true
  }
}
