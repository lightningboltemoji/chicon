//
//  SpecializedXattrs.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import Foundation

extension String: Error {}

class XattrsHelper {
    
    private let ATTR_FINDER_INFO = "com.apple.FinderInfo"
    private let ATTR_FINDER_INFO_LEN = 32
    private let ATTR_FINDER_INFO_CUSTOM_ICON_MASK: UInt8 = 4
    
    private let ATTR_RESOURCE_FORK = "com.apple.ResourceFork"
    
    private let path: String
    
    init(path: String) {
        self.path = path
    }
    
    func list() throws -> [String] {
        let len = listxattr(self.path, nil, 0, 0)
        guard len >= 0 else { throw "Unexpected error reading xattr length on: \(self.path)" }
        
        var nameBuffer = [CChar](repeating: 0, count: len)
        listxattr(self.path, &nameBuffer, len, 0)
        
        let names = String(cString: nameBuffer).components(separatedBy: "\0")
        return names.filter { !$0.isEmpty }
    }
    
    func clearCustomIconFlag() throws {
        if !(try list()).contains(ATTR_FINDER_INFO) {
            return
        }
        
        var buf = [UInt8](repeating: 0, count: ATTR_FINDER_INFO_LEN)
        getxattr(self.path, ATTR_FINDER_INFO, &buf, ATTR_FINDER_INFO_LEN, 0, 0)
        
        if buf[8] & ATTR_FINDER_INFO_CUSTOM_ICON_MASK > 0 {
            buf[8] = buf[8] ^ ATTR_FINDER_INFO_CUSTOM_ICON_MASK
            setxattr(self.path, ATTR_FINDER_INFO, buf, ATTR_FINDER_INFO_LEN, 0, 0)
        }
    }
    
    func clearResourceFork() {
        removexattr(self.path, ATTR_RESOURCE_FORK, 0)
    }
}
