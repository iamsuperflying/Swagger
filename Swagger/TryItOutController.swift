//
//  TryItOutController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/19.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit

class TryItOutController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let v: RequestParameterView = RequestParameterView.fromNib()
        v.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 400, height: 50))
        view.addSubview(v)
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
