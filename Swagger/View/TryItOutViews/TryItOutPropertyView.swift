//
//  TryItOutPropertyView.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/24.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class TryItOutPropertyView: UITableViewCell {
    
    @IBOutlet weak var docLabel: UILabel!

    @IBOutlet weak var propertyNameLabel: UILabel!
    
    var property: Property? {
        didSet {
            docLabel.text = property?.description
            propertyNameLabel.text = property?.name
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
