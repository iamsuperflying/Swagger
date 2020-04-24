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

extension UIViewController {
    class func fromNIb() -> Self {
        return Self.init(nibName: String(describing: self), bundle: Bundle.main)
    }
}
