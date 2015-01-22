//
//  shellrun.swift
//  pingtest
//
//  Created by Yong Lv on 1/21/15.
//  Copyright (c) 2015 lveyo. All rights reserved.
//

import Foundation

func shell(launchPath: String, arguments: [AnyObject] = []) -> String? {
    
    let task = NSTask()
    task.launchPath = launchPath
    task.arguments = arguments
    
    let pipe = NSPipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output: String? = NSString(data: data, encoding: NSUTF8StringEncoding)
    
    return output
}

func readfile(filename: String) ->String?{
    let fileContent = NSString(contentsOfFile: filename, encoding: NSUTF8StringEncoding, error: nil)
    return fileContent
}
