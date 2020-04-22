//
//  TreeFirstSearchMenuController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/19.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class TreeFirstSearchMenuController: UIViewController {

    @IBOutlet weak var menusView: UITableView!
    
    let searchAlgorithms = ["广度优先", "深度优先"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menusView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
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

extension TreeFirstSearchMenuController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            
            return 1
            
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchAlgorithms.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = searchAlgorithms[indexPath.row]
            cell.accessoryType = .detailButton
          
            return cell;
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
    
        func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            
            let alertController = TreeFSImageController.init(nibName: "TreeFSImageController", bundle: Bundle.main)
                  alertController.modalPresentationStyle = .popover
                  alertController.preferredContentSize = CGSize(width: 500, height: 300)
                  // Configure the alert controller's popover presentation controller if it has one.
                  if let popoverPresentationController = alertController.popoverPresentationController {
                      // Note for popovers the Cancel button is hidden automatically.
                      
//                    popoverPresentationController.sourceRect = cell?.frame as! CGRect
                      popoverPresentationController.sourceView = view
                      popoverPresentationController.permittedArrowDirections = .down
                  }
                  
                  present(alertController, animated: true, completion: nil)
        }

        
}
