//
//  NetworkingClient.swift
//  SeeMyPosts
//
//  Created by David Daniel Leah (BFS EUROPE) on 23/04/2019.
//  Copyright © 2019 David Daniel Leah (BFS EUROPE). All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient {
    private let url = "https://my-json-server.typicode.com/DanielLeah/JSONPlaceholderDemo/posts"
    func getData(_ url : URL, success: @escaping([Post]) -> Void, failure: @escaping (Error) -> Void){
        AF.request(url).validate().responseData(completionHandler: { (response) -> Void in
            let decoder = JSONDecoder()
            let posts : Result<Array<Post>, Error> = decoder.decodeResponse(from: response)
            switch posts{
                case .success(let item):
                    success(item)
                case .failure(_):
                    let error : Error = response.error!
                    failure(error)
                }
        })
    }
    func getPosts(noPosts : String, completion:@escaping ([Post])  -> ()){
        if let urlToExecute = URL(string: url + "?_page=1&_limit=\(noPosts)"){
            getData(urlToExecute, success: { (items) in
                completion(items)
            }) { (error) in
                print(error)
            }
            
        }
    }
    //delete
    func makeDeleteCall(with post: String) {
        let urlToDelete: String = url + "/\(post)"
        AF.request(urlToDelete, method: .delete).responseJSON { (response) in
            guard response.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling DELETE on /posts/\(post)")
                if let error = response.error {
                    print("Error: \(error)")
                }
                return
            }
            print("DELETE ok")
        }
    }
    //put
    func makePutCall(with post: Post) {
        let urlToPut: String = url + "/\(String(post.id))"
        let parameters : Parameters = [
            "userId" : post.userId,
            "id" : post.id,
            "title" : post.title,
            "body" : post.body
        ]
        
        
        AF.request(urlToPut, method: .put, parameters: parameters).responseJSON { (response) in
            guard response.error == nil else {
                // got an error in getting the data, need to handle it
                print("error calling PUT on /posts/\(post.id)")
                if let error = response.error {
                    print("Error: \(error)")
                }
                return
            }
            guard let json = response.value as? [String: Any] else {
                print("didn't get todo object as JSON from API")
                if let error = response.error {
                    print("Error: \(error)")
                }
                return
            }
            // get and print the title
            guard let idNumber = json["id"] as? Int else {
                print("Could not get id number from JSON")
                return
            }
            print("Created post with id: \(idNumber)")
        }
    }
}

