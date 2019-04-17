//
//  NYCSchoolDataModel.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation


struct NYCSchoolDataModel : Codable{
    
    let school_name : String?
    
    enum CodingKeys: String, CodingKey{
        case school_name = "school_name"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.school_name = try values.decodeIfPresent(String.self, forKey: .school_name)
    }
}
