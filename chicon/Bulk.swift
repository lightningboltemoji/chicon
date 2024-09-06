//
//  Bulk.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import Foundation
import ArgumentParser

struct ConfigFile: Decodable {
    let apply: Dictionary<String, String>
}

extension Chicon {
    struct Bulk: ParsableCommand {
        static let configuration = CommandConfiguration(
            commandName: "bulk",
            abstract: "Applies icons in bulk, based on configuration file in .config"
        )
        
        @Argument(help: "Location of the config file")
        var config: String = "~/.config/chicon/chicon.json"
        
        private func resolve(path: String) -> String {
            var p = path
            if p.hasPrefix("~") {
                let homeDirectory = FileManager.default.homeDirectoryForCurrentUser.path
                p = p.replacingOccurrences(of: "~", with: homeDirectory)
            } else if !p.hasPrefix("/") {
                let config = self.resolve(path: self.config)
                var configParent = URL(fileURLWithPath: config).deletingLastPathComponent()
                configParent.append(path: p)
                return configParent.path
            }
            return p
        }
        
        mutating func run() {
            self.config = self.resolve(path: self.config)

            var content: String
            do {
                content = try String(contentsOfFile: self.config, encoding: .utf8)
            } catch {
                print("Failed to read config file @ \(self.config)")
                Foundation.exit(1)
            }
            let data = content.data(using: .utf8)!
            let config: ConfigFile = try! JSONDecoder().decode(ConfigFile.self, from: data)
            config.apply.forEach { key, value in
                var status = "..."
                if FileManager.default.fileExists(atPath: value) {
                    let success = IconManager.set(icon: self.resolve(path: key), target: value)
                    status = success ? "✅" : "❌"
                }
                print("\(key) \(status)")
            }
        }
    }
}
