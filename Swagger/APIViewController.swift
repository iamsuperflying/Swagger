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
    
    @IBOutlet weak var propertiesTF: CodeView!
    
    @IBOutlet weak var responseTF: CodeView!
    
    @IBOutlet var themeButton: UIButton!
    var requestText = "" {
        didSet {
            propertiesTF.code = requestText
        }
    }
    var responseText = "" {
        didSet {
            responseTF.code = responseText
        }
    }
    
    var requests: Array<String>?
    var responses: Array<String>?
    
    var props: Array<Property>?
    
    var highlightr = Highlightr()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "接口"
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.themeButton)
        
        self.apiNameLabel.text = api?.name
        self.methodLabel.text = api?.method
        
        if let header = api?.httpMethod?.header {
            
        }
        propertiesTF.isHidden = true
//        responseTF.isHidden = api?.httpMethod?.response == nil
        
        if let req = api?.httpMethod?.request {
            requestText += firstSearchAlgorithm(definition: req, algorithm: .breadth)
        }
        if let resp = api?.httpMethod?.response {
            responseText = firstSearchAlgorithm(definition: resp, algorithm: .breadth)
        }

    }
    
    @IBAction func showCodeThemePicker(_ sender: UIButton) {
        let alertController = CodeThemeViewController.fromNIb()
//        alertController.delegate = self
        alertController.modalPresentationStyle = .popover
        alertController.preferredContentSize = CGSize(width: 250, height: 400)
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
    
        let activity = NSUserActivity(activityType: "TryItOut")
        
        Redis.standard.currentRequest = api?.httpMethod?.request
        
        UIApplication.shared.requestSceneSessionActivation(nil, userActivity: activity, options: nil) { (error) in
            //
            print("error is " + error.localizedDescription)
        }
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
    @IBAction func showRequestHeader(_ sender: UIButton) {
        let alertController = RequestHeaderController.fromNIb()
        alertController.modalPresentationStyle = .popover
        alertController.preferredContentSize = CGSize(width: 400, height: 280)
        if let header = api?.httpMethod?.header {
            alertController.header = header
        }
        // Configure the alert controller's popover presentation controller if it has one.
        if let popoverPresentationController = alertController.popoverPresentationController {
            let origin = CGPoint(x: sender.frame.minX, y: sender.superview!.frame.midY)
            popoverPresentationController.sourceRect = CGRect(origin: origin, size: sender.frame.size)
            popoverPresentationController.sourceView = view
            popoverPresentationController.permittedArrowDirections = .up
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

//extension APIViewController: CodeThemeProxy {
//
//    func didSelectedCodeTheme(theme: String) {
//        self.propertiesTF.attributedText = changeTheme(theme: theme, code: requestText)
//        self.responseTF.attributedText = changeTheme(theme: theme, code: responseText)
//    }
//
//}
 
