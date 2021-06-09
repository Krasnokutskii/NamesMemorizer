//
//  Person.swift
//  Project10
//
//  Created by Ярослав on 4/4/21.
//

import UIKit

class Person: NSObject,NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }

    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    

    var name: String
    var image: String
    
    init(image: String, name: String){
        self.image = image
        self.name = name
    }
    
}
