//
//  Bulk.swift
//  chicon
//
//  Created by Tanner on 9/5/24.
//

import Foundation
import ArgumentParser

struct ConfigFile: Decodable {
    var apply: Dictionary<String, String>
}

extension Chicon {
    struct Bulk: AsyncParsableCommand {
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
                let config = resolve(path: config)
                var configParent = URL(fileURLWithPath: config).deletingLastPathComponent()
                configParent.append(path: p)
                return configParent.path
            }
            return p
        }
        
        private func parse(path: String) -> ConfigFile {
            var content: String
            do {
                content = try String(contentsOfFile: path, encoding: .utf8)
            } catch {
                print("Failed to read config file @ \(path)")
                Foundation.exit(1)
            }
            let data = content.data(using: .utf8)!
            return try! JSONDecoder().decode(ConfigFile.self, from: data)
        }
        
        private static func doSet(target: String, icon: String) async -> String {
            var status = "..."
            if FileManager.default.fileExists(atPath: target) {
                let success = IconManager.set(target: target, icon: icon)
                status = success ? "✅" : "❌"
            }
            return status
        }
        
        mutating func run() async {
            var config = parse(path: resolve(path: config))
            config.apply.forEach { k, v in config.apply[k] = resolve(path: v) }
            
            let apply = config.apply
            let result = try! await withThrowingTaskGroup(of: (String, String).self) { group in
                for (key, value) in apply {
                    group.addTask {
                        return (key, await Bulk.doSet(target: key, icon: value))
                    }
                }
                
                var d = [String: String]()
                for try await (target, status) in group {
                    d[target] = status
                }
                return d
            }
            
            result.keys.sorted().forEach { k in
                print("\(k) \(result[k]!)")
            }
        }
    }
}
