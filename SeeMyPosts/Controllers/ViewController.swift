//
//  ViewController.swift
//  SeeMyPosts
//
//  Created by David Daniel Leah (BFS EUROPE) on 23/04/2019.
//  Copyright © 2019 David Daniel Leah (BFS EUROPE). All rights reserved.
// https://jsonplaceholder.typicode.com/posts
//https://jsonplaceholder.typicode.com/posts?_page=1&_limit=2

import UIKit
import Alamofire

class ViewController: UIViewController, PostUpdate {
    
    
    var posts = [Post]()
    var selectedPost : Post?
    @IBOutlet weak var getPostButton: UIButton!
    @IBOutlet weak var numberTextFiel: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func getPostButton(_ sender: UIButton) {
        
        let noPosts =  numberTextFiel.text!
        navigationItem.title = "\(noPosts) posts"
        guard let urlToExecute = URL(string: "https://jsonplaceholder.typicode.com/posts?_page=1&_limit=\(noPosts)") else {
            return
        }
        networkingClient.getData(urlToExecute, success: { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
    
    private let networkingClient = NetworkingClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPostButton.isEnabled = false
        numberTextFiel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    func editedPost(post: Post) {
        posts[post.id - 1] = post
        tableView.reloadData()
    }
    
    func deletedPost(post: Post) {
        let index = posts.firstIndex{$0.id == post.id}
        posts.remove(at: index!)
        tableView.reloadData()
    }
    
    //Delegates
    @objc func textFieldDidChange(){
        if numberTextFiel.text!.isNumber {
            getPostButton.isEnabled = true
        }else{
            getPostButton.isEnabled = false
        }
    }
}


