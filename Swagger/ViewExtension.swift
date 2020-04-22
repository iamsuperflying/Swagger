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
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! Self
    }
}

extension UIViewController {
    class func fromNIb() -> Self {
        return Self.init(nibName: String(describing: self), bundle: Bundle.main)
    }
}
