//
//  ArrayExtension.swift
//  Gutter
//
//  Created by Dev Team on 06/03/23.
//

import Foundation

extension Array {
    func arrayWithoutFirstElement() -> Array {
        if count != 0 { // Check if Array is empty to prevent crash
            var newArray = Array(self)
            newArray.removeFirst()
            return newArray
        }
        return []
    }
}
