//
//  TryItOutEnumView.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/24.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class TryItOutEnumView: TryItOutPropertyView {

    @IBOutlet weak var enumButton: UIButton!

    override var property: Property? {
        didSet {
            enumButton.setTitle(property?.enums?.first, for: .normal)
        }
    }
    
}
