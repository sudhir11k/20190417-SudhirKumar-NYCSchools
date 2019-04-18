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
    let dbn : String?
    
    enum CodingKeys: String, CodingKey{
        case school_name = "school_name"
        case dbn = "dbn"
    }
    
    init(from decoder: Decoder) throws{
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.school_name = try values.decodeIfPresent(String.self, forKey: .school_name)
        self.dbn = try values.decodeIfPresent(String.self, forKey: .dbn)
    }
}


struct NYCSchoolSatDataModal : Codable {
    let dbn : String?
    let num_of_sat_test_takers : String?
    let sat_critical_reading_avg_score : String?
    let sat_math_avg_score : String?
    let sat_writing_avg_score : String?
    let school_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case dbn = "dbn"
        case num_of_sat_test_takers = "num_of_sat_test_takers"
        case sat_critical_reading_avg_score = "sat_critical_reading_avg_score"
        case sat_math_avg_score = "sat_math_avg_score"
        case sat_writing_avg_score = "sat_writing_avg_score"
        case school_name = "school_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dbn = try values.decodeIfPresent(String.self, forKey: .dbn)
        num_of_sat_test_takers = try values.decodeIfPresent(String.self, forKey: .num_of_sat_test_takers)
        sat_critical_reading_avg_score = try values.decodeIfPresent(String.self, forKey: .sat_critical_reading_avg_score)
        sat_math_avg_score = try values.decodeIfPresent(String.self, forKey: .sat_math_avg_score)
        sat_writing_avg_score = try values.decodeIfPresent(String.self, forKey: .sat_writing_avg_score)
        school_name = try values.decodeIfPresent(String.self, forKey: .school_name)
    }
    
}

