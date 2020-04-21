//
//  Redis.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/21.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

final class Redis: NSObject {
    
    static let standard = Redis()
    
    private override init() {
        print("init")
    }
    
    var definitions = Dictionary<String, HTTPObject>()
    
//    static let standard: Redis = {
//        let instance = Redis()
//        // setup code
//        return instance
//    }()
}
