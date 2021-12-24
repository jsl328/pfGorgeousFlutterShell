////
////  FileIO.swift
////  Runner
////
////  Created by jiangsl on 2021/12/23.
////
//
//import Foundation
//import AppKit
//
//class FileIO{
//
//    static  func shellStandardFileIOWriter(flie : Any) ->String{
//        //------ 先定义一个文件的路径 ---------//
//        let manage = FileManager.default
//        let documentUrl = manage.urls(for: .documentDirectory, in: .userDomainMask);
////         manage.urls(for: .documentDirectory, in: .userDomainMask);
//        let Url = documentUrl[0] as NSURL
//        let fileUrl = Url.appendingPathComponent("test.txt")  //定义文件路径
//        var error : NSErrorPointer = nil;
//
//        if manage.fileExists(atPath: fileUrl?.path ?? "" ) == true {
//
//            //------ 1.文件内容定位 ---------//
//
//            var readHandler : FileHandle!  = try? FileHandle(forReadingFrom: fileUrl!) //该方法获取句柄成功时，会将指针指向文件开头
//            if #available(macOS 10.15, *) {
//                try? readHandler.seek(toOffset: 0);
//            } else {
//                // Fallback on earlier versionsfileDescriptorcloseOnDealloc ?? <#default value#>
//            };          //指针定位到文件头
//            var nsData = readHandler.readDataToEndOfFile() //读取从指针当前位置到末尾的所有数据
//            var strData : NSString! = NSString(data: nsData,encoding: String.Encoding.utf8.rawValue)
//
//            print("写入前文件内容=\(strData)")
//
//            //------ 2.文件数据写入 ---------//
//            let string = "+将这些数据写入到文件末尾"
//
////            let appendData : NSData! = string.dataUsingEncoding(String.Encoding.utf8.rawValue,allowLossyConversion: true)
//            let appendData : NSData! = string.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData?
////            String(d)
//            let writeHandler : FileHandle! = FileHandle(forReadingAtPath: fileUrl?.path!)  //该方法获取句柄成功时，会将指针指向文件开头
//            writeHandler.seekToEndOfFile()                //指针定位到文件末尾，即从末尾开始写入
//            writeHandler.writeData(appendData)
//
//            readHandler?.seekToFileOffset(0)
//            nsData= readHandler!.readDataToEndOfFile()
//            strData= NSString(data: nsData, encoding: NSUTF8StringEncoding)
//            println("写入后文件内容=\(strData)")
//
//    }
//}
//
