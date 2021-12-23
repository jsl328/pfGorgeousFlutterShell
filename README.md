# pfGorgeousFlutterShell

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Usage 

首先修改几个地方:

1、系统此目录下/Users/xxxx/.config/tekartik/process_run建env.yaml文件，如果存在就不创建只需要修改配置就行。

2、env.yaml配置,path指定路径，var指定环境变量，MY_PWD，MY_USER选填，[参考地址](https://github.com/tekartik/process_run.dart/blob/master/doc/user_config.md)如下:
```
path:
  - ./local
  - bin/
  - /Users/mac/Desktop/flutter/bin
# var:
   #ANDROID_TOP: ~/.android
  - FLUTTER_BIN: /Users/mac/Desktop/flutter/bin 
  - MY_PWD: xxxx  
  - MY_USER: xxxx
  ```
3、激活process_run,[参考地址](https://github.com/tekartik/process_run.dart/blob/master/doc/shell.md)
```

pub global active process_run $ alias ds='pub global run process_run:shell'

```
4、修改系统 .zshrc 文件,在文件的最下面添加如下代码:
```
export PATH=/Users/mac/Desktop/flutter/bin:$PATH 指定自己的flutter路径
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```
5、使 .zshrc文件生效
```
source .zshrc

```
## 使用实例

`which dart, flutter ,ls ,java`.
in my local env ,`which dart = /usr/local/flutter/bin/dart`;`which flutter = /usr/local/flutter/bin/flutter`;`which ls = /bin/ls`;`which java = /usr/bin/java`

execute `shell.run('/usr/local/flutter/bin/dart  --version')`
Dart SDK version: 2.16.0-85.0.dev (dev) (Mon Dec 6 21:50:02 2021 -0800) on "macos_x64"
    
execute `shell.run('/usr/local/flutter/bin/flutter')`
in addtional , show flutter help commmits
    
execute `shell.run('ls')` 
list current login user`s  workspaces

execute `shell.run('/usr/bin/java -version')`
stdout java version "1.8.0_271"
Java(TM) SE Runtime Environment (build 1.8.0_271-b09)    Java HotSpot(TM) 64-Bit Server VM (build 25.271-b09, mixed mode)
but `/usr/bin/java -version` have more bugs 