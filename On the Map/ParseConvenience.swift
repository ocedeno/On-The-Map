//
//  ParseConvenience.swift
//  On the Map
//
//  Created by Octavio Cedeno on 1/6/17.
//  Copyright © 2017 Octavio Cedeno. All rights reserved.
//

// MARK: Create URL from Parameters

extension ParseClient {
    
    func tmdbURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = "http"
        components.host = "parse.udacity.com/parse/classes/StudentLocation"
        components.path = Constants.TMDB.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
}
