//
//  HTTPObject.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class HTTPObject: HandyJSON {
    
    var type = "object"
    var properties: Dictionary<String, Property>?
    var title = ""
    
    required init() {}
}
