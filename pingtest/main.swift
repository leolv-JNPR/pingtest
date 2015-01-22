//
//  main.swift
//  pingtest
//
//  Created by Yong Lv on 1/21/15.
//  Copyright (c) 2015 lveyo. All rights reserved.
//

import Foundation

println("Starting speed test for vpnso......")
var filename = "./ips.txt"
if C_ARGC == 2 {
    filename = String.fromCString(C_ARGV[1])!
    //println(String.fromCString(C_ARGV[0])!)
}
//let path = NSBundle.mainBundle().pathForResource("ips", ofType: "txt")

let fileContent = readfile(filename)

if let filec = fileContent {
    
    let ipsarray = filec.componentsSeparatedByString("\n")
    
    for ip:String in ipsarray{
        let res:String? = shell("/sbin/ping", arguments: ["-c4", ip]);
        if let re = res{
            
            let rearray = re.componentsSeparatedByString("\n")
            if rearray.count > 2{
                let roundres = rearray[rearray.count-2]
                if roundres.rangeOfString("round-trip") != nil {
                    let speedarray = roundres.componentsSeparatedByString("/")
                    if speedarray.count > 6{
                        println("Host: "+ip+" time "+speedarray[4])
                    }
                } else {
                    println("Host: "+ip+" can't ping.")
                }
            }
        }
    }
} else {
    println("no content")
}

