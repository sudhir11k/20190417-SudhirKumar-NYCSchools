//
//  NYCSchoolDiretoryDataSource.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import Foundation
import UIKit


class NYCSchoolDiretoryDataSource : NSObject, UITableViewDataSource{
    var directoryVMList : [NYCSchoolDirectoryViewModelProtocol]?
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
            return cell
        }
        return UITableViewCell()
    }

}


extension NYCSchoolDiretoryDataSource : UITableViewDelegate{
    
   
}
