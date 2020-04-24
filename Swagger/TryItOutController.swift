//
//  TryItOutController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/19.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class TryItOutController: UIViewController {
    
    @IBOutlet weak var propertiesView: UITableView!
    var request: HTTPObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        propertiesView.register(TryItOutBoolView.toNib(), forCellReuseIdentifier: TryItOutBoolView.stringFromClass())
        propertiesView.register(TryItOutInputView.toNib(), forCellReuseIdentifier: TryItOutInputView.stringFromClass())
        propertiesView.register(TryItOutEnumView.toNib(), forCellReuseIdentifier: TryItOutEnumView.stringFromClass())
        
        // Do any additional setup after loading the view.
        if let req = Redis.standard.currentRequest {
           request = Redis.standard.definitions[req]
        }
        
        propertiesView.reloadData()
        
    }
    
    func handleProp(_ prop: Property) {
        /// integer / string / array / number / object / boolean / nil
        let propertyView: TryItOutPropertyView
       
//        switch prop.items?.type {
//        case "boolean":
//            propertyView = TryItOutBoolView.fromNib()
//            break
//        default:
//            propertyView = TryItOutInputView.fromNib()
//            break
//        }
//        propertyView.docLabel.text = prop.description
//        propertyView.propertyNameLabel.text = prop.name
//        propertiesView.addArrangedSubview(propertyView)
    }

}

extension TryItOutController: UITableViewDataSource, UITableViewDelegate {
    
        func numberOfSections(in tableView: UITableView) -> Int {
           
           return 1
           
        }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return request?.properties?.count ?? 0
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var ident = TryItOutInputView.stringFromClass()
        let property = request?.properties?[indexPath.row]
        if property?.items?.type == "boolean" {
            ident = TryItOutBoolView.stringFromClass()
        } else {
            
            if let enums = property?.enums {
                if !enums.isEmpty {
                    ident = TryItOutEnumView.stringFromClass()
                }
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ident, for: indexPath) as! TryItOutPropertyView
        
        cell.property = property
        return cell;
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let property = request?.properties?[indexPath.row]
        
        guard let enums = property?.enums else { return }
        
        let cell = tableView.cellForRow(at: indexPath) as! TryItOutEnumView
        
        let alertController = UIAlertController.init(title: "", message: "", preferredStyle: .actionSheet)
        
            alertController.modalPresentationStyle = .popover
        enums.forEach({
            
                    
                    let otherAction = UIAlertAction(title:$0, style: .default) {
                        print("The \"Other\" alert action sheet's other action occurred.")
                        
                        cell.enumButton.setTitle($0.title, for: .normal)
                    }
                    alertController.addAction(otherAction)
            
                 
        })
        
            // Configure the alert controller's popover presentation controller if it has one.
                             if let popoverPresentationController = alertController.popoverPresentationController {
                                 
                                 popoverPresentationController.sourceRect = cell.frame
                                 popoverPresentationController.sourceView = view
                                 popoverPresentationController.permittedArrowDirections = .up
                             }
                             
                             present(alertController, animated: true, completion: nil)
        
       }
    
}
