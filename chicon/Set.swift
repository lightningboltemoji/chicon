//
//  Set.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import Foundation
import ArgumentParser

extension Chicon {
    struct Set: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Applies a custom icon to a file or folder"
        )
        
        @Argument(help: "Path to apply to")
        var target: String
        
        @Argument(help: "Path to icon")
        var icon: String
        
        mutating func run() {
            print("Applying icon '\(icon)' to '\(target)'")
            if IconManager.set(target: target, icon: icon) {
                print("Success!")
            } else {
                print("Failed :(")
            }
        }
    }
}
