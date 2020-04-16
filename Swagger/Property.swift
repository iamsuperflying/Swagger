//
//  Property.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Property: Scheme {
    
    var type: String?
    var format: String?
    var description: String?
    var items: Scheme?
    var enums: Array<String>?
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<<
            self.enums <-- "enum"
    }
    
}
