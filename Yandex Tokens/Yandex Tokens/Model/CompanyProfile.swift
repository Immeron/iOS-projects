//
//  CompanyProfile.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 13.04.2021.
//

import Foundation

struct CompanyProfile: Decodable {
    
    var country: String
    var currency: String
    var exchange: String
    var ipo: String
    var marketCapitalization: Float
    var name: String
    var phone: String
    var shareOutstanding: Float
    var ticker: String
    var weburl: String
    var logo: String
    var finnhubIndustry: String
    
}
