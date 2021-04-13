//
//  ParseJSON.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 13.04.2021.
//

import Foundation


final class ParseJSON {
    var network = DataTaskURLSession()
    
    func parseJSON<T: Decodable>(URL: String,typeJSON: T.Type, completion: @escaping (T?)->()) {
        network.dataTaskURL(urlString: URL) { (data, responce, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            let decoder = JSONDecoder()
            guard let data = data else { return }
            do {
                let object = try decoder.decode(typeJSON.self, from: data)
                completion(object)
            }catch{
                print("Fail")
                completion(nil)
            }
        }
    }
    
}

