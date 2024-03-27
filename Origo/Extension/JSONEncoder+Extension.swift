//
//  JsonEncoder+Extension.swift
//  TimeApp
//
//  Created by Kamaljeet Punia on 15/07/20.
//  Copyright © 2020 Tina. All rights reserved.
//

import Foundation

extension JSONEncoder {
    
    ///This method will convert the Codable type model(T) to return type(U).
    ///Usage => let dict: [String: Any] = JSONEncoder().convertToDictionary(model)
    ///Parameter and return type both are generic
    func convertToDictionary<T: Encodable, U>(_ model: T) -> U? {
        do {
            let data = try JSONEncoder().encode(model)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? U
            return dictionary
        }catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
    
    func convertToData<T: Encodable>(_ model: T) -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(model)
    }
}

extension JSONDecoder {
    func convertDataToModel<T: Decodable>(_ data: Data) -> T? {
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch {
            debugPrint(error)
            return nil
        }
    }
}
