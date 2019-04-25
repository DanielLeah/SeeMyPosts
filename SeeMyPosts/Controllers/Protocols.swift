//
//  Protocols.swift
//  SeeMyPosts
//
//  Created by David Daniel Leah (BFS EUROPE) on 25/04/2019.
//  Copyright © 2019 David Daniel Leah (BFS EUROPE). All rights reserved.
//

import Foundation


protocol PostUpdate : NSObjectProtocol {
    func editedPost(post : Post)
    func deletedPost(post : Post)
}
