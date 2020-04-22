//
//  APIViewController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Highlightr

class APIViewController: UIViewController {
    
    var api: API?
    var definitions = Dictionary<String, HTTPObject>()
    
    @IBOutlet weak var methodLabel: UILabel!
    
    @IBOutlet weak var apiNameLabel: UILabel!
    
    @IBOutlet weak var propertiesTF: UITextView!
    
    @IBOutlet weak var responseTF: UITextView!
    
    @IBOutlet var themeButton: UIButton!
    var requestText = "" {
        didSet {
            propertiesTF.attributedText = changeTheme(theme: "xcode", code: requestText)
        }
    }
    var responseText = "" {
        didSet {
            responseTF.attributedText = changeTheme(theme: "xcode", code: responseText)
        }
    }
    
    var requests: Array<String>?
    var responses: Array<String>?
    
    var props: Array<Property>?
    
    let highlightr = Highlightr()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "接口"
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.themeButton)
        
        self.apiNameLabel.text = api?.name
        self.methodLabel.text = api?.method
        
        if let header = api?.httpMethod?.header {
            
        }
        let body = api?.httpMethod?.body
        
        if let req = api?.httpMethod?.request {
            requestText += firstSearchAlgorithm(definition: req, algorithm: .breadth)
        }
        if let resp = api?.httpMethod?.response {
            responseText = firstSearchAlgorithm(definition: resp, algorithm: .breadth)
        }

    }
    
    @IBAction func showCodeThemePicker(_ sender: UIButton) {
        let alertController = CodeThemeViewController.fromNIb()
        alertController.delegate = self
        alertController.modalPresentationStyle = .popover
        alertController.preferredContentSize = CGSize(width: 300, height: 200)
        // Configure the alert controller's popover presentation controller if it has one.
        if let popoverPresentationController = alertController.popoverPresentationController {
            // Note for popovers the Cancel button is hidden automatically.
            
            // This method expects a valid cell to display from.
            let x = view.frame.width - 20 - sender.frame.width * 0.5
            
            popoverPresentationController.sourceRect = CGRect(x: x , y: sender.frame.maxY, width: sender.frame.width, height: sender.frame.height)
            popoverPresentationController.sourceView = view
            popoverPresentationController.permittedArrowDirections = .up
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func tryItOut(_ sender: Any) {
        let tryItOutController = TryItOutController.fromNIb()
            // TryItOutController.init(nibName: "TryItOutController", bundle: Bundle.main)
        
        present(tryItOutController, animated: true, completion: nil)
//        navigationController?.pushViewController(tryItOutController, animated: true)
    }
    @IBAction func btnCustomMenuClick(sender: UIButton) {
        
        let alertController = TreeFirstSearchMenuController.fromNIb()
        alertController.modalPresentationStyle = .popover
        alertController.preferredContentSize = CGSize(width: 300, height: 200)
        // Configure the alert controller's popover presentation controller if it has one.
        if let popoverPresentationController = alertController.popoverPresentationController {
            // Note for popovers the Cancel button is hidden automatically.
            
            // This method expects a valid cell to display from.
            popoverPresentationController.sourceRect = sender.frame
            popoverPresentationController.sourceView = view
            popoverPresentationController.permittedArrowDirections = .down
        }
        
        present(alertController, animated: true, completion: nil)
        
    }

}

extension APIViewController {
    
    func firstSearchAlgorithm(definition: String, algorithm: Algorithm) -> String {
        
        var result = ""
        /// 根
        guard let httpObject = definitions[definition] else { return result }
        
        var stack = [httpObject]
        
        var titles:Set<String> = []
        
        if let childrens = httpObject.childrens {
            stack += childrens
        }
        
        while !stack.isEmpty {
            let obj = stack.removeFirst()
            
            /// 之前有没有
            let contains = titles.contains(obj.title)
            titles.insert(obj.title)
            if contains {
                continue
            }
            
            print("httpObject title is " + obj.title + " level is \(obj.level)" )
            print("httpObject \(String(describing: obj.propertiesFormat))")
            
            result += obj.propertiesFormat
            
//            result += "@interface " + obj.title + "()"
//            result += "\n\n"
//            result += obj.propertiesFormat ?? ""
//            result += "\n"
//            result += "@end\n\n"
            
            if let childrens = obj.childrens {
                if !childrens.isEmpty {
                    switch algorithm {
                    case .breadth:
                        stack += childrens
                        break
                    case .depth:
                        stack = childrens + stack
                        break
                    }
                    
                }
            }
        }
        return result
    }
}

extension APIViewController: CodeThemeProtocol {
    
    func didSelectedCodeTheme(theme: String) {
        self.responseTF.attributedText = changeTheme(theme: theme)
    }
    
    func changeTheme(theme: String) -> NSAttributedString? {
        highlightr?.setTheme(to: theme)
        highlightr?.theme.setCodeFont(RPFont(name: "JetBrainsMono-Regular", size: 30) ?? RPFont.systemFont(ofSize: 30))
        responseTF.backgroundColor = highlightr?.theme.themeBackgroundColor
        propertiesTF.backgroundColor = highlightr?.theme.themeBackgroundColor
        let code = requestText
        // You can omit the second parameter to use automatic language detection.
        return highlightr?.highlight(code, as: "swift")
    }
    
    func changeTheme(theme: String, code: String) -> NSAttributedString? {
        highlightr?.setTheme(to: theme)
        highlightr?.theme.setCodeFont(RPFont(name: "JetBrainsMono-Regular", size: 30) ?? RPFont.systemFont(ofSize: 30))
        responseTF.backgroundColor = highlightr?.theme.themeBackgroundColor
        propertiesTF.backgroundColor = highlightr?.theme.themeBackgroundColor
        // You can omit the second parameter to use automatic language detection.
        return highlightr?.highlight(code, as: "swift")
    }
    
}
 
