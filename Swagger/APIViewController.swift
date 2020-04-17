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
    
    @IBOutlet weak var methodLabel: UILabel!
    
    @IBOutlet weak var apiNameLabel: UILabel!
    
    @IBOutlet weak var propertiesTF: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.apiNameLabel.text = api?.name
        self.methodLabel.text = api?.method
    
       
        
        api?.httpMethod?.parameters.forEach({ (paramter) in
            /// 取出 resuest
            if let ref = paramter.schema?.ref {
                if let httpObject = definitions?[ref] {
                    httpObject.properties?.forEach({ (k, p) in
//                        print("key is \(k) value is\(p.description)")
                        print(p.propertyFormat(v: k))
                        self.propertiesTF.text = p.propertyFormat(v: k)
                        forEachProps(ref: p.ref)
                    })
            }
            }
            
            
//            paramter.schema?.reference
//            debugPrint(paramter.toJSONString())
        })
        
    }
    
    func definitionsForEach() {
        definitions?.forEach({ (k, v) in
               v.properties?.forEach({ (k, p) in
                   print(p.propertyFormat(v: k))
                   
                   self.propertiesTF.text = p.propertyFormat(v: k)
               
                   forEachProps(ref: p.ref)
               })
        })
    }

    func forEachProps(ref: String?) -> Void {
        guard ref != nil else {
            return
        }
        if let httpObject = definitions?[ref!] {
            httpObject.properties?.forEach({ (k, v) in
                
                if let ref = v.items?.ref {
//                    print("type is \(String(describing: v.type))")
                    forEachProps(ref: ref)
                } else {
//                    print("key is \(k)")
                }
            })
        }
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
