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
            abstract: "Applies a custom icon to a target"
        )
        
        @Argument(help: "Path to icon")
        var icon: String
        
        @Argument(help: "Path to apply to")
        var target: String
        
        mutating func run() {
            print("Applying icon '\(icon)' to '\(target)'");
            if IconManager.set(icon: self.icon, target: self.target) {
                print("Success!");
            } else {
                print("Failed :(");
            }
        }
    }
}
