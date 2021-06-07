//
//  Person.swift
//  Project10
//
//  Created by Ярослав on 4/4/21.
//

import UIKit

class Person: NSObject {

    var name: String
    var image: String
    
    init(image: String, name: String){
        self.image = image
        self.name = name
    }
    
}
