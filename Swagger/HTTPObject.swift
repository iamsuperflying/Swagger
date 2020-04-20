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
    var children = Array<HTTPObject>()
    /// 父节点
    weak var parent: HTTPObject?
    
    /// 没有子节点的节点
    var isLeaf: Bool {
        return self.childrens?.count ?? 0 <= 0
    }

    lazy var childrens:Array<HTTPObject>? = {
        if let result = self.properties?.compactMap({
            UserDefaults.definitions()?[$0.ref ?? ""]
        }) {
            return result
        }
        return nil
    }()
    
    required init() {}
    
}

// MARK: - Computed
extension HTTPObject {

}

// MARK: - Mapping
extension HTTPObject {
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.properties <-- Reformer<Property>.Reformer()
    }
}
