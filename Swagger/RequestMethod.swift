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
    
    lazy var header: [Parameter]? = {
        self.parameters?.compactMap({
            $0.p_in == "header" ? $0 : nil
        })
    }()
    
    lazy var body: [Parameter]? = {
        self.parameters?.compactMap({
            $0.p_in == "body" ? $0 : nil
        })
    }()
    
    lazy var token: Parameter? = {
        self.parameters?.compactMap({
            $0.name == "token" ? $0 : nil
        }).first
    }()
    
    lazy var request: String? = {
        if let requests = self.parameters?.compactMap({$0.schema?.ref}) { return requests.first}
        return nil
    }()
    
    lazy var response = {
        self.responses?.success?.schema?.ref
    }()
    
    required init() {}
}
