//
//  Scheme.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Scheme: HandyJSON {

    var reference: String?
    
    /// 引用的类
    var ref: String? {
        reference?.components(separatedBy: "/").last
    }
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.reference <-- "$ref"
    }
    
}
