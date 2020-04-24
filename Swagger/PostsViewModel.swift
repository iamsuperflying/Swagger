//
//  Post.swift
//  Swagger
//
//  Created by 李鹏飞 on 2020/4/24.
//  Copyright © 2020 LPF. All rights reserved.
//

import UIKit
import Combine

final class PostsViewModel: ObservableObject {
    
    let objectWillChange = PassthroughSubject<Void, Never>()

    private (set) var posts: [Post] = []

    func fetch() {
        // fetch posts
        objectWillChange.send()
        // assign new data to the posts variable
    }
}
