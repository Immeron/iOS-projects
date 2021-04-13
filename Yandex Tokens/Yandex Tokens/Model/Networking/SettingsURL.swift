//
//  SettingsURL.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 13.04.2021.
//

import Foundation

final class SettingsURL {
    
    func stringInURL(urlString: String, completion: @escaping (URL?)->()){
        let finalURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let URL = URL(string: finalURL!) else {
            completion(nil)
            return
        }
        completion(URL)
    }
    
}
