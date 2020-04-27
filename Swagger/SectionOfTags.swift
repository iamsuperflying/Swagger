//
//  SectionOfTags.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/27.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import RxDataSources

struct SectionOfTags: SectionModelType {
      
      var items: [Tag]
      
      typealias Item = Tag
      
    init(original: SectionOfTags, items: [Tag]) {
          self = original
          self.items = items
      }
  }
