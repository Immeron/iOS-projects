//
//  DataTaskURLSession.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 13.04.2021.
//

import Foundation

final class DataTaskURLSession {
    var setURL = SettingsURL()
    
    func dataTaskURL(urlString: String, completion: @escaping (Data?,URLResponse?,Error?)->()) {
        setURL.stringInURL(urlString: urlString) { (url) in
            guard (url != nil) else{
                return
            }
            let session = URLSession.shared
            session.dataTask(with: url!) { (data, responce, error) in
                if error == nil && data != nil{
                    completion(data,responce,nil)
                }else{
                    completion(nil,nil,error)
                }
            }.resume()
        }
    }
    
}
