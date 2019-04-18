//
//  NYCSchoolDirectoryFactory.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation


// Directory View Modal


protocol NYCSchoolDirectoryViewModelProtocol{
    var school_name : String {get}
    var dbn : String {get}
}


struct NYCSchoolDirectoryVM : NYCSchoolDirectoryViewModelProtocol{
    var school_name : String
    var dbn : String
    init(withDirectoryModel directory: NYCSchoolDataModel) {
        self.school_name = directory.school_name ?? "School Name- N/A"
        self.dbn = directory.dbn ?? "NA"
        
    }
}


// SAT DATA View Modal

protocol NYCSchoolSATViewModelProtocol{
    
    var dbn : String? {get}
    var num_of_sat_test_takers : String? {get}
    var sat_critical_reading_avg_score : String? {get}
    var sat_math_avg_score : String? {get}
    var sat_writing_avg_score : String? {get}
    var school_name : String? {get}
}

// SAT View Modal

struct NYCSchoolSATVM : NYCSchoolSATViewModelProtocol{
    var dbn : String?
    var num_of_sat_test_takers : String?
    var sat_critical_reading_avg_score : String?
    var sat_math_avg_score : String?
    var sat_writing_avg_score : String?
    var school_name : String?
    
    init(withSATDataModel dataSAT: NYCSchoolSatDataModal) {
        self.dbn = dataSAT.dbn
        self.num_of_sat_test_takers = dataSAT.num_of_sat_test_takers
        self.sat_critical_reading_avg_score = dataSAT.sat_critical_reading_avg_score
        self.sat_math_avg_score = dataSAT.sat_math_avg_score
        self.sat_writing_avg_score = dataSAT.sat_writing_avg_score
        self.school_name = dataSAT.school_name
    }
}

protocol NYCSchoolDirectoryFactoryProtocol {
    
    func generateDirectoryViewModel(withDataModel dataModel: [NYCSchoolDataModel]) -> [NYCSchoolDirectoryViewModelProtocol]
    
    func generateSATDATAViewModel(withDataModel dataModel: [NYCSchoolSatDataModal]) -> [NYCSchoolSATViewModelProtocol]
}


class NYCSchoolDirectoryFactory : NYCSchoolDirectoryFactoryProtocol{
    
    /// generateDirectoryViewModel - Factory method to create ViewModal using DataModal
    ///
    /// - Parameter dataModel: NYCSchoolDataModel which has School Directory information
    /// - Returns: return Array of SchoolDirectory ViewModal [NYCSchoolDirectoryViewModelProtocol]
    func generateDirectoryViewModel(withDataModel dataModel: [NYCSchoolDataModel]) -> [NYCSchoolDirectoryViewModelProtocol] {
        
        var directoryViewModalArr : [NYCSchoolDirectoryViewModelProtocol] = []
        for schoolDataModel in dataModel {
            let dir_viewModal = NYCSchoolDirectoryVM(withDirectoryModel: schoolDataModel as! NYCSchoolDataModel)
            directoryViewModalArr.append(dir_viewModal)
        }
        
        return directoryViewModalArr
    }
    
    /// generateSATDATAViewModel - Factory method to create ViewModal using DataModal
    ///
    /// - Parameter dataModel: NYCSchoolSatDataModal which has Score information
    /// - Returns: return Array of SATDATA ViewModal [NYCSchoolSATViewModelProtocol]
    func generateSATDATAViewModel(withDataModel dataModel: [NYCSchoolSatDataModal]) -> [NYCSchoolSATViewModelProtocol] {
        
        var satDataViewModalArr : [NYCSchoolSATViewModelProtocol] = []
        for satDataModel in dataModel {
            let dir_viewModal = NYCSchoolSATVM(withSATDataModel: satDataModel as! NYCSchoolSatDataModal)
            satDataViewModalArr.append(dir_viewModal)
        }
        return satDataViewModalArr
    }
}





