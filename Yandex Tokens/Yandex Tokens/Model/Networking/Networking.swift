//
//  Networking.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 21.03.2021.
//

import Foundation

final class Networking {
    static var shared = Networking()
    public init(){}
    var parseJSON = ParseJSON()
    
    
    
    func setupData(completion: @escaping ([CompanyProfile])->()){
        let urlSymbols = "https://finnhub.io/api/v1/index/constituents?symbol=^DJI&token=c1a6j5v48v6q19j51300"
        var dataProfile = [CompanyProfile]()
        let disGroup = DispatchGroup()
        parseJSON.parseJSON(URL: urlSymbols, typeJSON: TopSymbol.self) { (decode) in
            for temp in decode!.constituents{
                disGroup.enter()
                let urlSymbol = "https://finnhub.io/api/v1/stock/profile2?symbol=\(temp)&token=c1a6j5v48v6q19j51300"
                self.parseJSON.parseJSON(URL: urlSymbol, typeJSON: CompanyProfile.self) { (decodeComp) in
                    dataProfile.append(decodeComp!)
                    disGroup.leave()
                }
            }
            disGroup.notify(queue: DispatchQueue.main) {
                completion(dataProfile)
                
            }
            
        }
    }
  
    
}







