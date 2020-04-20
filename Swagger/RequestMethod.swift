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
    var summary = ""
    var operationId: String?
    var parameters: [Parameter]?
    var responses: Responses?
    var deprecated = false
    
    lazy var request: String? = {
        if let requests = self.parameters?.compactMap({$0.schema?.ref}) { return requests.first}
        return nil
    }()
    
    lazy var response = {
        self.responses?.success?.schema?.ref
    }()
    
    required init() {}
}
