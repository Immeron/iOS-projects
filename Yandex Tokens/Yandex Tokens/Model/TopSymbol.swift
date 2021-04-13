//
//  TopSymbols.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 13.04.2021.
//

import Foundation

struct TopSymbol: Decodable {
    
    var constituents: [String]
    var symbol: String
}
