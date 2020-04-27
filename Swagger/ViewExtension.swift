//
//  ViewExtension.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/19.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

extension UIView {
    
    class func fromNib() -> Self {
        Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! Self
    }
    
    class func toNib() -> UINib {
        UINib(nibName: self.stringFromClass(), bundle: Bundle.main)
    }
    
}

extension UITableView {
    
    func register(cellClass: AnyClass?, isNib:Bool = false) {
        
        guard let cls = cellClass else { return }
        
        let stringFromClass = String(describing:cls)
        
        if isNib {
            self.register(UINib(nibName: stringFromClass, bundle: Bundle.main), forCellReuseIdentifier: stringFromClass)
            return
        }
        self.register(cls, forCellReuseIdentifier: stringFromClass)
    }
}

extension UIViewController {
    class func fromNIb() -> Self {
        return Self.init(nibName: String(describing: self), bundle: Bundle.main)
    }
}
