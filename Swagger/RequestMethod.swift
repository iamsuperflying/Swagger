//
//  RequestMethod.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class RequestMethod: HandyJSON {

    var tags:Array<String>?
    var summary:String?
    var operationId: String?
    var parameters = [Parameter]()
    var responses: Responses?
    var deprecated = false
    
    required init() {}
}
