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
    func getData(_ url : URL, success: @escaping([Post]) -> Void, failure: @escaping (Error) -> Void){
        AF.request(url).validate().responseData(completionHandler: { (response) -> Void in
            let decoder = JSONDecoder()
            let todo : Result<Array<Post>, Error> = decoder.decodeResponse(from: response)
            switch todo{
                case .success(let item):
                    success(item)
                case .failure(_):
                    let error : Error = response.error!
                    failure(error)
                }
        })
    }
}
