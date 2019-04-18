//
//  NYCSchoolDiretoryDataSource.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation
import UIKit


protocol NYCSchoolDataSourceDelegate{
    func getSatDataOnCellSelection(satData:NYCSchoolSATViewModelProtocol?)
}

class NYCSchoolDiretoryDataSource : NSObject, UITableViewDataSource{
    var directoryVMList : [NYCSchoolDirectoryViewModelProtocol]?
    var satDataVMList : [NYCSchoolSATViewModelProtocol]?
    var delegate : NYCSchoolDataSourceDelegate?
    let directoryCellIdentifier = "NYCSchoolDirectoryCellIdentifier"
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directoryVMList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.directoryTableViewCell(for: tableView, at: indexPath)
    }
    
    private func directoryTableViewCell(for tableView:UITableView, at indexPath: IndexPath) -> UITableViewCell{
        if let directoryVM = directoryVMList?[indexPath.row]{
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: directoryCellIdentifier)
            cell.textLabel?.text = directoryVM.school_name
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

}


extension NYCSchoolDiretoryDataSource : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let directoryVM = directoryVMList?[indexPath.row]{
            let dbn = directoryVM.dbn
            if let satData = satDataVMList?.first(where: {$0.dbn == dbn}) {
                print(satData)
                self.delegate?.getSatDataOnCellSelection(satData: satData)
            }else{
                self.delegate?.getSatDataOnCellSelection(satData: nil)
            }
 
        }
    }
    
   
}
