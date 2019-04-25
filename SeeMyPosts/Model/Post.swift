//
//  Post.swift
//  SeeMyPosts
//
//  Created by David Daniel Leah (BFS EUROPE) on 23/04/2019.
//  Copyright © 2019 David Daniel Leah (BFS EUROPE). All rights reserved.
//

import UIKit

struct Post : Codable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
}
