//
//  IconManager.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import AppKit

class IconManager {
    private static let workspaceLock = NSLock()
    
    static func set(target: String, icon: String) -> Bool {
        let img = NSImage.init(contentsOfFile: icon)
        workspaceLock.lock()
        defer { workspaceLock.unlock() }
        return NSWorkspace.shared.setIcon(img, forFile: target, options: NSWorkspace.IconCreationOptions(rawValue: 2))
    }
    
    static func clear(target: String) throws {
        let xat = XattrsHelper(path: target)
        try xat.clearCustomIconFlag()
        xat.clearResourceFork()
        
        var isDirectory = ObjCBool(true)
        if FileManager.default.fileExists(atPath: target, isDirectory: &isDirectory) && isDirectory.boolValue {
            (try? FileManager.default.removeItem(atPath: target + "/Icon\r"))
            (try? FileManager.default.removeItem(atPath: target + "/.VolumeIcon.icns"))
        }
    }
}
