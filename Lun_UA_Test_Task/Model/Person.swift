//
//  Person.swift
//  Lun_UA_Test_Task
//
//  Created by Yura Velko on 2/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

struct Person {
    let name: String
    let address: String
    let lat: String
    let lng: String
    let imageUrls: [String]
    let phone: String
    var photoIndex: Int = 0
    
    
    init(name: String, address: String, lat: String, lng: String, imageUrls: [String], phone: String) {
        
        if address == "ул. Б. Хмельницкого 44" {
            self.address = NSLocalizedString("st. B. Khmelnitsky 44", comment: "")
        } else {
            self.address = address
        }
        self.name = name
        self.lat = lat
        self.lng = lng
        self.imageUrls = imageUrls
        self.phone = phone
    }
}

