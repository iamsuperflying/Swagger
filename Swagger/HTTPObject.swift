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
    
    // MARK: - Tree
    /// 层级
    var level = 0
    /// 子节点
    /// 父节点
    weak var parent: HTTPObject?

    lazy var childrens:Array<HTTPObject>? = {
        self.properties?.compactMap({
            if let children = Redis.standard.definitions[$0.ref ?? ""] {
                children.parent = self
                children.level = self.level + 1
                return children
            }
            return nil
        })
    }()
    
    lazy var propertiesFormat: String = {
        var resultStr = "\n@interface " + title + "()\n\n"
        
        if let resultString = self.properties?.reduce("", {(result, prop) -> String in
            result + prop.propertyFormat()
        }) {
            resultStr += resultString + "\n@end\n\n"
        }
        return resultStr
    }()
    
    required init() {}
    
}

// MARK: - Computed
extension HTTPObject {

    /// 没有子节点的节点
    var isLeaf: Bool {
        return self.childrens?.isEmpty ?? true
    }
}

// MARK: - Mapping
extension HTTPObject {
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.properties <-- Reformer<Property>.Reformer()
    }
}
