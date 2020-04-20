//
//  API.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class API: Definition {
    
    var name: String?
    var post: RequestMethod?
    var get: RequestMethod?
    
    var httpMethod: RequestMethod? {
        (post != nil) ? post : get
    }
    
    var tag:String {
        httpMethod?.tags?.first ?? ""
    }
    
    var method: String {
        (post != nil) ? "POST" : "GET"
    }
    
    required init() {}
}
