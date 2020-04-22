//
//  Property.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import HandyJSON

class Property: Items, Definition {
    
    // MARK: - Key
    /// 这个值是一定有的
    var name: String!
    
    var description: String?
    var items: Items?
    
    override var ref: String? {
        items?.ref ?? refLastPathComponent
     }
    
}

extension Property {
    
    // MARK: - Computed
    
    var propertyType: String {
        /// type is nil
        if let p_type = type {
            return p_type
        }
        if let p_ref = ref {
            return p_ref
        }
        
        if let p_items_ref = items?.ref {
            return p_items_ref
        }
        
        return ""
    }
    
    /// memory-management-keyword
    /// integer / string / array / number / object / boolean / nil
    var memoryManagementKeyword: String {
        var keyword = "strong *"
        switch propertyType {
        case "string":
            keyword = "copy *"
            break
        case "integer":
            keyword = "assgin "
            break
        case "array":
            keyword = "strong *"
            break
        case "number":
            keyword = "strong *"
            break
        case "boolean":
            keyword = "assgin "
            break
        default:
            break
        }
        return keyword
    }
    
    func propertyFormat() -> String {
        var doc = ""
        if let desc = description {
            doc = "///" + " " + desc + "\n"
        }
        if let en = enums {
            doc = "///" + " [" + en.joined(separator: ", ") + "]\n"
        }
        return doc + "@property (nonatomic, " + memoryManagement(name) + name + ";\n"
    }
    
    func memoryManagement(_ v: String) -> String {
        var keyword = "strong"
        var point   = ""
        var type    = propertyType
        switch propertyType {
        case "string":
            keyword = "copy"
            point   = "*"
            type    = "NSString"
            break
        case "integer":
            keyword = "assgin"
            point   = ""
            type    = "NSInteger"
            break
        case "array":
            keyword = "strong"
            point   = "*"
            type = "NSArray"
            if let generics = items?.generics {
                type = "NSArray<\(generics) *>"
            }
            
            break
        case "number":
            if format == "double" {
                keyword = "assgin"
                point   = ""
                type    = "CGFloat"
            } else {
                keyword = "strong"
                point   = "*"
                type    = "NSNumber"
            }

            break
        case "boolean":
            keyword = "assgin"
            point   = ""
            type    = "BOOL"
            break
        default:
            break
        }
        return keyword + ") " + type + " " + point
    }
}
