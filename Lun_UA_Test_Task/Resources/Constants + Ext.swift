//
//  Constants + Ext.swift
//  Lun_UA_Test_Task
//
//  Created by Yura Velko on 2/23/19.
//  Copyright © 2019 Yura Velko. All rights reserved.
//

import UIKit

let nameTitle = NSLocalizedString("Name: ", comment: "")
let phoneTitle = NSLocalizedString("Phone number: ", comment: "")
let mapButtonTitle = NSLocalizedString("Return to point", comment: "")

let jsonString = """
    {
        "person": {
            "person_id": "1",
            "name": "Smile",
            "address": "ул. Б. Хмельницкого 44",
            "phone": "+38 (067) 335-83-18",
            "profile_image_id": "11",
            "lat": "50.446985",
            "lng": "30.5077463"
        },
    "images": [
        {
            "image_id": "11",
            "link": "https://i.pinimg.com/736x/8b/b4/1c/8bb41cd3738254e52808707eb737c43f.jpg"
        },
        {
            "image_id": "12",
            "link":"https://i.pinimg.com/736x/82/fa/8a/82fa8a8d0abac9e28614df1f5c45efeb.jpg"
        },
        ]
    }
"""


extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
