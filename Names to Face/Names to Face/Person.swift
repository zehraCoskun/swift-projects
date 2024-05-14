//
//  Person.swift
//  Names to Face
//
//  Created by Zehra Coşkun on 14.05.2024.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
