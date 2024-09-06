//
//  Remove.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import ArgumentParser

extension Chicon {
    struct Remove: ParsableCommand {    
        static let configuration = CommandConfiguration(
            commandName: "rm",
            abstract: "Removes a custom icon from a target"
        )
        
        @Argument(help: "Path to remove from")
        var target: String
        
        mutating func run() {
            do {
                try IconManager.clear(target: self.target)
            } catch {
                print("Failed to clear custom icon")
            }
        }
    }
}
