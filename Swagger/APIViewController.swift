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
    
    @IBOutlet weak var methodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = api?.name
        if api?.post != nil {
            self.methodLabel.text = "POST"
        } else {
            self.methodLabel.text = "GET"
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
