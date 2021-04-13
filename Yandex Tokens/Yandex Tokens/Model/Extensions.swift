//
//  extensions.swift
//  Yandex Tokens
//
//  Created by Илья Виноградов on 29.03.2021.
//

import UIKit

extension UIImageView {
    func load(urlString: String,completion: @escaping (UIImage)->()) {
        guard let url = URL(string: urlString) else {
            completion(UIImage(systemName: "xmark")!)
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                        completion(image)
                    }
                }
            }
        }
    }
}
