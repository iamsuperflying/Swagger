//
//  CodeThemeViewController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/22.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Highlightr

protocol CodeThemeProtocol {
    func didSelectedCodeTheme(theme: String)
}

class CodeThemeViewController: UIViewController {
    
    var delegate:CodeThemeProtocol?
    
    @IBOutlet weak var themeListView: UITableView!
    let availableThemes = Highlightr()?.availableThemes()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.themeListView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

}

extension CodeThemeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableThemes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = availableThemes?[indexPath.row]
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectedCodeTheme(theme: availableThemes![indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
