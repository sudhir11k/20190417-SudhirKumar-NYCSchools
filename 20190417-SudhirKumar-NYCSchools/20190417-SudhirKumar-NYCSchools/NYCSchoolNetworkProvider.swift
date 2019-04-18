//
//  NYCSchoolNetworkProvider.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation
protocol NYCSchoolNetworkProviderProtocol {
    func callingNYCSchoolServiceApi(_ urlString: String, completionHandler:@escaping ((Data?, NYCCustomError?, Bool) -> ()))
}

enum NYCCustomError: Error {
    case urlError
    case error(descritption:String)
    
    
}

enum NYCSchoolUrl : String{
    case schoolDirectory
    case dataSAT
    
    var urlPath : String {
        switch self {
        case .schoolDirectory:
            return "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        case .dataSAT:
            return "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        }
    }
}

class NYCSchoolNetworkProvider: NYCSchoolNetworkProviderProtocol {
    
    /// callingNYCSchoolServiceApi - Used to call Network call
    ///
    /// - Parameters:
    ///   - urlString: will be in String form
    ///   - completionHandler: callback Handler to return the control to Caller
    func callingNYCSchoolServiceApi(_ urlString: String, completionHandler: @escaping ((Data?, NYCCustomError?, Bool) -> ())) {
        
        guard let url = URL(string: urlString) else{
            let error = NYCCustomError.urlError
            completionHandler(nil, error, false)
            return
        }
        
        let urlDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil){
                completionHandler(nil,NYCCustomError.error(descritption: error?.localizedDescription ?? "URL Seesion Error"),false)
            }
            
            if let data = data{
                print(data)
               // print(String(data: data, encoding: String.Encoding.utf8.self))
                completionHandler(data, nil, true)
            }
            
        }
        urlDataTask.resume()
    }
    
   
    
}

