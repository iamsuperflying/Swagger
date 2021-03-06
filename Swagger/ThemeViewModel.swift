//
//  ThemeViewModel.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/26.
//  Copyright © 2020 LPF. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ThemeViewModel {
    
    let theme: Observable<String>?
    
    init(theme: Observable<String>) {
        self.theme = theme
    }
    
}
