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
    
    var tag:String {
        get {
            return tags?.first ?? ""
        }
    }
    
    var summary:String {
        get {
            return post?.summary ?? get?.summary ?? ""
        }
    }
    var operationId: String?
    var parameters = [Parameter]()
    var responses: Responses?
    var deprecated = false
    
    var tags:Array<String>? {
        get {
            return post?.tags ?? get?.tags ?? nil
//            if let p_tags = post?.tags {
//                return p_tags
//            }
//            if let g_tags = get?.tags {
//                return g_tags
//            }
//            return nil
        }
    }
    
    
    required init() {}
}
