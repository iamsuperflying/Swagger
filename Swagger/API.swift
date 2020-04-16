//
//  API.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class API: HandyJSON {
    
    var name: String?
    var post: RequestMethod?
    var get: RequestMethod?
    
    var tags:Array<String>? {
        get {
            if let p_tags = post?.tags {
                return p_tags
            }
            if let g_tags = get?.tags {
                return g_tags
            }
            return nil
        }
    }
    
    
    required init() {}
}
