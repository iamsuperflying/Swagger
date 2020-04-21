//
//  Reformer.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/20.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

typealias Structure = Dictionary<String, Dictionary<String, Any>>

protocol Definition: HandyJSON {
    var name: String! { get set }
}

extension Definition {
    
}

class Reformer<T:Definition> {

     static func Reformer<T:Definition>() -> TransformOf<Array<T>, Structure> {
        return TransformOf<Array<T>, Structure> (
            fromJSON: { (apis) -> Array<T>? in
            
                apis?.compactMap({
                    var t:T? = T.deserialize(from: $0.value)
                    t?.name = $0.key
                    return t
                })

        }, toJSON:{ (model) -> Structure? in
            return nil
        })
    }
    
}

protocol Equal {
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension Array where Element:HTTPObject {
    
    func unique( titles: inout Set<String>) -> [HTTPObject] {
        return self.filter {
            /// 之前有没有
            let contains = titles.contains($0.title)
            titles.insert($0.title)
            return !contains
        }
    }
    
    var unique:[Element] {
        var titles = Set<String>()
        return self.filter {
            /// 之前有没有
            let contains = titles.contains($0.title)
            titles.insert($0.title)
            return !contains
            
            /// 有
            /// add 过滤掉了
            /// false
            
            /// 没有
            /// add
            /// true
        }
    }
}
