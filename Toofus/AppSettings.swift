//
//  File.swift
//  SwiftUIMenu
//
//  Created by Denis Vinogradov on 04.04.2020.
//  Copyright © 2020 Denis Vinogradov. All rights reserved.
//

import Foundation

class AppSettings: ObservableObject {
    @Published var currentSubMenu = 1
    @Published var currentMenu = 1
	@Published var chapter : Int? = -1
	@Published var font = "Avenir"
	@Published var settingMenu = false
	@Published var colorIndex = 1
	@Published var back = Double(1)
	@Published var chapters = Bundle.main.decode("content.json")

	let colors = [0x5443AF, 0x393232, 0x1EAD50, 0xE88613, 0x1E69E2, 0xC334D6, 0x8B2DEA, 0xEDCC14]

}

struct Chapter: Decodable, Identifiable {
    public var id: String
    public var text: String
    enum CodingKeys: String, CodingKey {
           case id = "id"
           case text = "text"
        }
}


extension Bundle {
    func decode(_ file: String) -> [Chapter] {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode([Chapter].self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
