//
//  APIViewController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/16.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class APIViewController: UIViewController {
    
    var api: API?
    var definitions: Dictionary<String, HTTPObject>?
    
    @IBOutlet var hehe: UIMenu!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var methodLabel: UILabel!
    
    @IBOutlet weak var apiNameLabel: UILabel!
    
    @IBOutlet weak var propertiesTF: UITextView!
    
    @IBOutlet weak var responseTF: UITextView!
    
    var requestText = ""
    var responseText = ""
    
    var requests: Array<String>?
    var responses: Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.apiNameLabel.text = api?.name
        self.methodLabel.text = api?.method
        
//        closure(ref: "") {
//
//        }
    
        /// resuest
        api?.httpMethod?.parameters.forEach({ (paramter) in
            /// 取出 resuest
            requestText += closure(ref: paramter.schema?.ref) { }
            
//            if let ref = paramter.schema?.ref {
//                if let httpObject = definitions?[ref] {
//                    requestText += ref
//                    requestText += "\n\n"
//                    httpObject.properties?.forEach({ (k, p) in
//                        print("*****" + p.propertyFormat(v: k))
//                        requestText += p.propertyFormat(v: k)
//                        /// 以下是 Request 所需要的模型
//                        /// forEachProps(ref: p.ref)
//                    })
//               }
//            }
        })
        
        propertiesTF.text = requestText
        
        /// response
        if let $ref = api?.httpMethod?.responses?.success?.schema?.ref {
            if let httpObject = definitions?[$ref] {
                responseText += $ref
                responseText += "\n\n"
                httpObject.properties?.forEach({ (k, p) in
                    print("*****" + p.propertyFormat(v: k))
                    responseText += p.propertyFormat(v: k)
                    forEachProps(ref: p.ref)
                })
           }
        }
        
        responseTF.text = responseText
        
        
        
    }
    
    func closure(ref: String?, forEach: () -> Void) -> String {
        var text = ""
        if let $ref = ref,
            let httpObject = definitions?[$ref] {
                text += $ref
                text += "\n\n"
                httpObject.properties?.forEach({ (k, p) in
                    print("*****" + p.propertyFormat(v: k))
                    text += p.propertyFormat(v: k)
                    forEachProps(ref: p.ref)
                    forEach()
                })
        }
        return text
    }
    
    /// 遍历某个属性中的属性
    func forEachP(prop: Property) -> Array<String>? {
        /// 如果包含自定义对象
        if let $ref = prop.ref {
            var props = Array<String>()
            props.append($ref)
            return props
        }
        
        return nil
    }

    func forEachProps(ref: String?) {
        guard ref != nil else {
            return
        }
        print("######" + ref!)
        self.propertiesTF.text = self.propertiesTF.text + "\n\n" + ref!
        if let httpObject = definitions?[ref!] {
            httpObject.properties?.forEach({ (k, p) in
                
                if let ref = p.items?.ref {
                    self.propertiesTF.text = self.propertiesTF.text + "\n\n" + k
                    forEachProps(ref: ref)
                } else {
                    
//                    self.propertiesTF.text = self.propertiesTF.text + p.propertyFormat(v: k)
//                    print("key is \(k)")
                }
            })
        }
    }
    
    @IBAction func tryItOut(_ sender: Any) {
        let tryItOutController = TryItOutController.init(nibName: "TryItOutController", bundle: Bundle.main)
        
        present(tryItOutController, animated: true, completion: nil)
//        navigationController?.pushViewController(tryItOutController, animated: true)
    }
    @IBAction func btnCustomMenuClick(sender: UIButton) {
//        let message = "设置解析对象的排列顺序\n\n广度优先搜索\n(优先解析第一个自定义对象的第一个自定义对象)\n\n深度优先搜索"
//        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
//
//        // Create the actions.
//        let otherAction = UIAlertAction(title: "广度优先搜索", style: .default) { _ in
//            print("The \"Other\" alert action sheet's destructive action occurred.")
//        }
//        let anotherAction = UIAlertAction(title: "深度优先搜索", style: .default) { _ in
//            print("The \"Other\" alert action sheet's other action occurred.")
//        }
//
//        // Add the actions.
//        alertController.addAction(otherAction)
//        alertController.addAction(anotherAction)
        
        let alertController = TreeFirstSearchMenuController.init(nibName: "TreeFirstSearchMenuController", bundle: Bundle.main)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
