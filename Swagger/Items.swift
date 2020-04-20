//
//  Items.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/17.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Items: Scheme {
    
    /// integer / string / array / number / object / boolean / nil
    var type: String?
    
    /// type: integer / double
    var format: String?
    
    /// string 数组
    var enums: Array<String>?
    
    var generics: String {
        
        /// 数组范型 NSString
        if type == "string" {
            /// 可能存在的值的列表
            if enums != nil {
                
            }
            
            return "NSString"
        }
        
        else if let $ref = ref {
            print("$ref = \($ref)")
            return $ref
        }
            
        else if format != nil {
            return "NSNumber"
        }
        
        return ""
    }
    
    
    override func mapping(mapper: HelpingMapper) {
        super.mapping(mapper: mapper)
        mapper <<<
            self.enums <-- "enum"
    }
}
