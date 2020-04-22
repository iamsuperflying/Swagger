//
//  Protocols.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/22.
//  Copyright © 2020 LPF. All rights reserved.
//

import Foundation
import Highlightr

protocol CodeThemeProtocol {
    
    var highlightr: Highlightr? { get set }
    
    func didSelectedCodeTheme(theme: String)
       
    func changeTheme(theme: String, code: String) -> NSAttributedString?
    
    func changeTheme(theme: String, code: String, as languageName: String) -> NSAttributedString?
    
    func themeBackGround() -> UIColor?
}

protocol CodeThemeProxy: CodeThemeProtocol {
    
}

extension CodeThemeProxy {
    
    var highlightr: Highlightr? {
        return Highlightr()
    }

    func changeTheme(theme: String, code: String) -> NSAttributedString? {
        highlightr?.setTheme(to: theme)
        highlightr?.theme.setCodeFont(RPFont(name: "JetBrainsMono-Regular", size: 30) ?? RPFont.systemFont(ofSize: 30))
        // You can omit the second parameter to use automatic language detection.
        return highlightr?.highlight(code, as: "swift")
    }
    
    func changeTheme(theme: String, code: String, as languageName: String) -> NSAttributedString? {
        highlightr?.setTheme(to: theme)
        highlightr?.theme.setCodeFont(RPFont(name: "JetBrainsMono-Regular", size: 30) ?? RPFont.systemFont(ofSize: 30))
        // You can omit the second parameter to use automatic language detection.
        return highlightr?.highlight(code, as: languageName)
    }
    
    func themeBackGround() -> UIColor? {
        return highlightr?.theme.themeBackgroundColor
    }
    
}
