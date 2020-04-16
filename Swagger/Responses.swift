//
//  Responses.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Responses: HandyJSON {
    
    var success: Success?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.success <-- "200"
    }
    
}
