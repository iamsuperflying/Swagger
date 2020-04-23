//
//  RequestHeaderController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/22.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class RequestHeaderController: UIViewController {
    
    @IBOutlet weak var textView: CodeView!
    var header = [Parameter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.code = header.reduce("", {
            $0 + ($1.toJSONString()?.jsonFormatPrint() ?? "")
        })
    }

}
