//
//  Parameter.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Parameter: HandyJSON {
    
    var p_in = ""
    var name = ""
    var description = ""
    var required = false
    var schema:Scheme?
    var type:String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.p_in <-- "in"
    }
}
