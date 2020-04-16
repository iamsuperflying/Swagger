//
//  Tag.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/15.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Tag: HandyJSON {
    
    var name: String = ""
    var tag_description: String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.tag_description <-- "description"
    }
    
}
