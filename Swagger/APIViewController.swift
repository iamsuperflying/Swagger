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
    var definitions = Dictionary<String, HTTPObject>()
    
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
    
    var props: Array<Property>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.apiNameLabel.text = api?.name
        self.methodLabel.text = api?.method
        
//        closure(ref: "") {
//
//        }
        
//        traverse()
        print("httpObject 广度优先-------------------------")
        BFS(definition: "GetIndexInfoResponse")
        
//        print("httpObject 深度优先-------------------------")
//        DFS(definition: "GetIndexInfoResponse")
        
//        if let resp = api?.httpMethod?.response {
//            BFS(http: resp)
//        }
    
//        /// resuest
//        api?.httpMethod?.parameters?.forEach({ (paramter) in
//            /// 取出 resuest
//            requestText += closure(ref: paramter.schema?.ref) { }
//
////            if let ref = paramter.schema?.ref {
////                if let httpObject = definitions?[ref] {
////                    requestText += ref
////                    requestText += "\n\n"
////                    httpObject.properties?.forEach({ (k, p) in
////                        print("*****" + p.propertyFormat(v: k))
////                        requestText += p.propertyFormat(v: k)
////                        /// 以下是 Request 所需要的模型
////                        /// forEachProps(ref: p.ref)
////                    })
////               }
////            }
//        })
//
//        propertiesTF.text = requestText
//
//        /// response
//        if let $ref = api?.httpMethod?.responses?.success?.schema?.ref {
//            if let httpObject = definitions[$ref] {
//                responseText += $ref
//                responseText += "\n\n"
////                httpObject.properties?.forEach({ (k, p) in
////                    print("*****" + p.propertyFormat(v: k))
////                    responseText += p.propertyFormat(v: k)
////                    forEachProps(ref: p.ref)
////                })
//           }
//        }
//
//        responseTF.text = responseText
        
        
        
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
        if let httpObject = definitions[ref!] {
//            httpObject.properties?.forEach({ (k, p) in
//
//                if let ref = p.items?.ref {
//                    self.propertiesTF.text = self.propertiesTF.text + "\n\n" + k
//                    forEachProps(ref: ref)
//                } else {
//
////                    self.propertiesTF.text = self.propertiesTF.text + p.propertyFormat(v: k)
////                    print("key is \(k)")
//                }
//            })
        }
    }
    
    @IBAction func tryItOut(_ sender: Any) {
        let tryItOutController = TryItOutController.init(nibName: "TryItOutController", bundle: Bundle.main)
        
        present(tryItOutController, animated: true, completion: nil)
//        navigationController?.pushViewController(tryItOutController, animated: true)
    }
    @IBAction func btnCustomMenuClick(sender: UIButton) {
        
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

extension APIViewController {
    
    func BFS(definition: String) {
        
        /// 根
        guard let httpObject = definitions[definition] else { return }
        
        var stack = [HTTPObject]()
        
        var titles:Set<String> = [httpObject.title]
        
        if let childrens = httpObject.childrens {
            stack = childrens.unique(titles: &titles)
        }
        
        while stack.count > 0 {
            let obj = stack.removeFirst()
            print("httpObject title is " + obj.title + " level is \(obj.level)" )
            print("httpObject \(String(describing: obj.propertiesFormat))")
            
            self.requestText += obj.title
            self.requestText += "\n\n"
            self.requestText += obj.propertiesFormat ?? ""
            self.requestText += "\n\n"
            self.propertiesTF.text = requestText
            if let childrens = obj.childrens {
                if childrens.count > 0 {
                    stack += childrens
                }
            }
            stack = stack.unique(titles: &titles)
            print(stack)
            
        }
        
    }
    
    func DFS(definition: String) {
        
        var stack = [HTTPObject]()
        
        /// 根
        let httpObject = definitions[definition]
        
        if let childrens = httpObject?.childrens {
            stack = childrens
        }
        
        var obj: HTTPObject?
        while stack.count > 0 {
            obj = stack.removeFirst()
            print("httpObject title is " + obj!.title + " level is \(obj!.level)" )
            if let childrens = obj?.childrens {
                if childrens.count > 0 {
                    stack = childrens + stack
                }
            }
//            stack = stack.unique
        }
        
    }
    
}
 
