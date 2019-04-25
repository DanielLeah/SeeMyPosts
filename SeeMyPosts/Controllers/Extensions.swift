//
//  Extensions.swift
//  SeeMyPosts
//
//  Created by David Daniel Leah (BFS EUROPE) on 24/04/2019.
//  Copyright © 2019 David Daniel Leah (BFS EUROPE). All rights reserved.
//

import UIKit
import Alamofire

extension JSONDecoder{
    func decodeResponse<T : Decodable>(from response: DataResponse<Data>) -> Result<Array<T>, Error> {
        guard response.error == nil else {
            print("Respinse error\(response.error!)")
            return .failure(response.error!)
        }
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(BackendError.parsing(reason: "Error in getting the response"))
        }
        do {
            let item = try decode(Array<T>.self, from: responseData)
            return .success(item)
        }catch {
            print("Error trying to decode response")
            print(error)
            return .failure(error)
        }
    }
}

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
    case parsing(reason: String)
}

extension String {
    var isNumber: Bool {
        let characters = CharacterSet.decimalDigits.inverted
        return !self.isEmpty && rangeOfCharacter(from: characters) == nil
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
