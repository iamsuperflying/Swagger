//
//  CodeView.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/22.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Highlightr

class CodeView: UITextView, CodeThemeDelegate {
    
    @IBInspectable var languageName: String = "swift"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Redis.standard.addDelegate(delegate: self)
    }
    
    var code: String = "" {
        didSet {
            Redis.standard.changeTheme()
        }
    }
    
    func textView() -> UITextView {
        return self
    }

}
