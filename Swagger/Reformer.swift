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

extension CodeThemeProtocol {
    
}

extension String {
    
    func jsonFormatPrint() -> String {
     
        if (self.starts(with: "{") || self.starts(with: "[")){
            var level = 0
            var jsonFormatString = String()
            
            func getLevelStr(level:Int) -> String {
                var string = ""
                for _ in 0..<level {
                    string.append("\t")
                }
                return string
            }
            
            for char in self {
                
                if level > 0 && "\n" == jsonFormatString.last {
                    jsonFormatString.append(getLevelStr(level: level))
                }
                
                switch char {
                    
                case "{":
                    fallthrough
                case "[":
                    level += 1
                    jsonFormatString.append(char)
                    jsonFormatString.append("\n")
                case ",":
                    jsonFormatString.append(char)
                    jsonFormatString.append("\n")
                case "}":
                    fallthrough
                case "]":
                    level -= 1;
                    jsonFormatString.append("\n")
                    jsonFormatString.append(getLevelStr(level: level));
                    jsonFormatString.append(char);
                    break;
                default:
                    jsonFormatString.append(char)
                }
            }
            return jsonFormatString;
        }
        
        return self
    }
}

