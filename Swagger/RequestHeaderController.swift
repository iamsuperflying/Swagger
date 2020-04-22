//
//  RequestHeaderController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/22.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Highlightr

class RequestHeaderController: UIViewController, CodeThemeProxy {
    
    var highlightr = Highlightr()
    
    func didSelectedCodeTheme(theme: String) {
        
    }
    
    @IBOutlet weak var textView: UITextView!
    var header = [Parameter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let text = header.reduce("", { (r, p) -> String in
            r + (p.toJSONString()?.jsonFormatPrint() ?? "")
        })
        textView.attributedText = changeTheme(theme: "xcode", code: text, as: "json")
        textView.backgroundColor = themeBackGround()
        view.backgroundColor = themeBackGround()
    }

}
