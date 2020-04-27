//
//  Redis.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/21.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Highlightr

protocol CodeThemeDelegate {
    
    var languageName: String {get set}
    
    var code: String { get set }
    
    func textView() -> UITextView
}

final class Redis: NSObject {
    
    static let standard = Redis()
    
    private override init() {
        print("init")
    }
    
    var definitions = Dictionary<String, HTTPObject>()
    var currentRequest: String?
    
    let highlightr = Highlightr()
    
    var theme: String = (UserDefaults.standard.value(forKey: "theme") as? String ) ?? "xcode"
    
    private lazy var delegates: [CodeThemeDelegate]? = {
        return [CodeThemeDelegate]()
    }()
    
    let availableThemes:[String] = Highlightr()?.availableThemes() ?? []
    
    var fontSize:CGFloat = 25
    
    func changeTheme() {
        changeTheme(theme: theme)
    }
    
    func changeTheme(theme: String) {
        saveTheme(theme)
        highlightr?.setTheme(to: theme)
        highlightr?.theme.setCodeFont(RPFont(name: "JetBrainsMono-Regular", size: fontSize)
        ?? RPFont.systemFont(ofSize: fontSize))
        // You can omit the second parameter to use automatic language detection.
        changeCode()
    }
    
    private func saveTheme(_ theme: String) {
        UserDefaults.standard.set(theme, forKey: "theme")
    }
    
    private func changeCode() {
        self.delegates?.forEach({
            let languageName = $0.languageName
            $0.textView().backgroundColor = themeBackGround()
            $0.textView().attributedText = highlightr?.highlight($0.code, as: languageName)
        })
    }
    
    func themeBackGround() -> UIColor? {
        return highlightr?.theme.themeBackgroundColor
    }
    
    func addDelegate(delegate: CodeThemeDelegate?) {
        guard let _delegate = delegate else { return }
        delegates?.append(_delegate)
    }
    
// 闭包形式的单例
//    static let standard: Redis = {
//        let instance = Redis()
//        // setup code
//        return instance
//    }()
}
