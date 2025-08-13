//
//  Chicon.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import ArgumentParser
import Foundation

@main
struct Chicon: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "set and remove custom icons",
        subcommands: [Apply.self, Set.self, Remove.self]
    )
}
