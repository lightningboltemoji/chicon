//
//  main.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import Foundation
import AppKit

clearIcon(dest: CommandLine.arguments[2]);
clearIcon(dest:"/Applications/AeroSpace.app");

func listXattrs(dest: String) -> [String] {
    let bufferLength = listxattr(dest, nil, 0, 0)
    if bufferLength == -1 {
        print("Error listing xattrs: \(errno)")
        return []
    }
    
    var nameBuffer = [CChar](repeating: 0, count: bufferLength)
    listxattr(dest, &nameBuffer, bufferLength, 0)
    
    let names = String(cString: nameBuffer).components(separatedBy: "\0")
    return names.filter { !$0.isEmpty }
}

func setIcon(src: String, dest: String) {
    print("Setting \(src) on \(dest)");

    let img = NSImage.init(contentsOfFile: src);
    let success = NSWorkspace.shared.setIcon(img, forFile: dest, options: NSWorkspace.IconCreationOptions(rawValue: 2));
    if (success) {
        print("Icon has been set!");
    } else {
        print("Icon failed to set");
    }
}

func clearIcon(dest: String) {
    let attrs = listXattrs(dest: dest)
    if attrs.contains("com.apple.FinderInfo") {
        let valueLength = getxattr(dest, "com.apple.FinderInfo", nil, 0, 0, 0)
        var valueBuffer = [UInt8](repeating: 0, count: valueLength)
        getxattr(dest, "com.apple.FinderInfo", &valueBuffer, valueLength, 0, 0)
        
        if valueBuffer[8] & 4 > 0 {
            print("Removed flag")
            valueBuffer[8] = valueBuffer[8] ^ 4
            setxattr(dest, "com.apple.FinderInfo", valueBuffer, 32, 0, 0)
        } else {
            print("Custom icon flag not set")
        }
    }
    if attrs.contains("com.apple.ResourceFork") {
        print("Removed ResourceFork")
        removexattr(dest, "com.apple.ResourceFork", 0)
    }
    
    var isDirectory = ObjCBool(true)
    if FileManager.default.fileExists(atPath: dest, isDirectory: &isDirectory) && isDirectory.boolValue {
        print("Is a directory")
        (try? FileManager.default.removeItem(atPath: dest + "/Icon\r"))
    }
}

func testIcon(dest: String) {
    
}
