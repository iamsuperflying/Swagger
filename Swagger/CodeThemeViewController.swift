//
//  CodeThemeViewController.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/22.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CodeThemeViewController: UIViewController {
    
    @IBOutlet weak var themeListView: UITableView!
    let availableThemes:[String] = Redis.standard.availableThemes
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.themeListView.register(cellClass: UITableViewCell.self)
        
        let themesObservable = Observable.from(optional: availableThemes)
        themesObservable.bind(to:
            themeListView.rx.items(cellIdentifier: UITableViewCell.stringFromClass(),
                                                         cellType: UITableViewCell.self)) { (row, text, cell) in
            cell.textLabel?.text = text
        }.disposed(by: disposeBag)
        
        themeListView.rx.itemSelected.bind{ indexPath in
            Redis.standard.changeTheme(theme: self.availableThemes[indexPath.row])
        }.disposed(by: disposeBag)

    }

}
