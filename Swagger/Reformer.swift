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

extension UserDefaults {
    static func definitions() -> Dictionary<String, HTTPObject>? {
        return UserDefaults.standard.dictionary(forKey: "definitions") as? Dictionary<String, HTTPObject>
    }
    
    static func setDefinitions(definitions: Dictionary<String, HTTPObject>) {
        UserDefaults.standard.set(definitions, forKey: "definitions")
    }
}
