//
//  main.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import Foundation
import ArgumentParser

@main
struct Chicon: AsyncParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "set and remove custom icons",
        subcommands: [Bulk.self, Set.self, Remove.self]
    )
}
