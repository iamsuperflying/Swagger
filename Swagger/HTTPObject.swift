//
//  HTTPObject.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class HTTPObject: HandyJSON {
    
    var type = "object"
    var properties: Array<Property>?
    
    var title = ""
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
        self.properties <-- TransformOf<Array<Property>, Dictionary<String, Dictionary<String, Any>>> (
            fromJSON: { (propDict) -> Array<Property>? in
                
                propDict?.compactMap({
                    if let prop = Property.deserialize(from: $0.value) {
                        prop.name = $0.key
                        return prop
                    }
                    return nil
                })

        }, toJSON:{ (bbb) -> Dictionary<String, Dictionary<String, Any>>? in
            return nil
        })
    }
}
