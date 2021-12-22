import 'GrepEntity.dart';
import 'package:process_run/shell.dart';

class GrepCommand {
  static Future<GrepEntity?> grepRunShellCommandPath(String commandPath) async {
    var grepEntityInstance = GrepEntity();
    if (commandPath.isEmpty) {
      print("value为空");
      grepEntityInstance.status = 404;
      grepEntityInstance.grepName = commandPath;
      grepEntityInstance.grepRes = "commandScript 为空";
    }
    var newWhich = which(commandPath);
    grepEntityInstance.grepName = commandPath;
    if (newWhich == null) {
      print("本机whic路径未找到");
      grepEntityInstance.status = 401;
      grepEntityInstance.grepRes = "本机whic路径未找到";
    } else {
      newWhich.then((value) => {
            // print("object----$value"),
            grepEntityInstance.status = 200,
            grepEntityInstance.grepRes = value.toString()
          });
    }
    return grepEntityInstance;
  }

  static String? grepSyncRunShellCommandPath(String commandPath) {
    if (commandPath.isEmpty) {
      return 'commandPath 为空';
    } else {
      return whichSync(commandPath);
    }
  }
}
