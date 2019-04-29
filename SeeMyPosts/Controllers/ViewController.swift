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
    private let networkingClient = NetworkingClient()
    
    @IBOutlet weak var getPostButton: UIButton!
    @IBOutlet weak var numberTextFiel: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func getPostButton(_ sender: UIButton) {
        let noPosts =  numberTextFiel.text!
        navigationItem.title = "\(noPosts) posts"
        
        networkingClient.getPosts(noPosts: noPosts) { (items) in
            self.posts = items
            self.tableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPostButton.isEnabled = false
        numberTextFiel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    func editedPost(post: Post) {
        posts[post.id - 1] = post
        networkingClient.makePutCall(with: post)
        tableView.reloadData()
    }
    
    func deletedPost(post: Post) {
        let index = posts.firstIndex{$0.id == post.id}
        networkingClient.makeDeleteCall(with: String(post.id))
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

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].id.description
        cell.detailTextLabel?.text = posts[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = posts[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let vc = segue.destination as! DetailViewController
            guard let selectedPost = selectedPost else {return}
            vc.post = selectedPost
            vc.delegate = self
        }
    }
}

