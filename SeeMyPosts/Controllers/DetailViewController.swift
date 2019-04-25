//
//  DetailViewController.swift
//  SeeMyPosts
//
//  Created by David Daniel Leah (BFS EUROPE) on 24/04/2019.
//  Copyright © 2019 David Daniel Leah (BFS EUROPE). All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    //UIViews
    @IBOutlet weak var idUserText: UITextField!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var editDone: UIButton!
    
    @IBAction func deleteButton(_ sender: Any) {
        //delete and dismiss
        if let delegate = delegate {
            delegate.deletedPost(post: post)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    @IBAction func edit(_ sender: Any) {
        
        if editDone.titleLabel?.text == "Done"{
            editDone.setTitle("Edit", for: .normal)
            idUserText.isUserInteractionEnabled = false
            titleText.isUserInteractionEnabled = false
            detailText.isUserInteractionEnabled = false
            updatePost(Int(idUserText.text!)! , titleText.text!, detailText.text!)
        }else{
            editDone.setTitle("Done", for: .normal)
            idUserText.isUserInteractionEnabled = true
            titleText.isUserInteractionEnabled = true
            detailText.isUserInteractionEnabled = true
            
        }
        
    }
    
    weak var delegate : PostUpdate?
    
    var post : Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetails()
    }

    func updateDetails() {
        navigationItem.title = "\(post.id) Detailed post"
        idUserText.text! = post.userId.description
        titleText.text! = post.title
        detailText.text! = post.body
        
    }
    
    func updatePost(_ idUser: Int, _ title:String, _ body:String){
        post.body = body
        post.userId = idUser
        post.title = title
        if let delegate = delegate {
            delegate.editedPost(post: post)
        }
    }
}
