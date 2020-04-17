//
//  MetaResponse.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/15.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class MetaResponse: HandyJSON {
    
    let swagger = ""
    let host = ""
    let basePath = ""
    let tags = [Tag]()
    var paths = [API]()
    
    var pathsMapping = Dictionary<String, Array<API>>()
    var definitions: Dictionary<String, HTTPObject>?
    
    required init() {}
    
    /// 把一个数组根据 tag 来进行分组,
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.paths <-- TransformOf<Array<API>, Dictionary<String, Any>> (
                fromJSON: { (apis) -> Array<API>? in
                    
                    return apis?.map { (key, value) -> API in
                        
                        if let api = API.deserialize(from: value as? Dictionary) {
                            api.name = key
                            return api
                        }
                        return API()
                    }

            }, toJSON:{ (bbb) -> Dictionary<String, Any>? in
                return nil
            })
        
    }
}
