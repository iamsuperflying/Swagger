//
//  TryItOutController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/19.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class TryItOutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let v = RequestParameterView.fromNib()
        v.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 50))
        view.addSubview(v)
    }

}
