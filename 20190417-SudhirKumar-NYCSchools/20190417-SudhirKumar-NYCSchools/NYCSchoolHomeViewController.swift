//
//  ViewController.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import UIKit

class NYCSchoolHomeViewController: UIViewController {

    @IBOutlet weak var schoolDirectoryTable: UITableView!
    
    var managerNYCSchool = NYCSchoolManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        managerNYCSchool.getSchoolDirectoryList { (dataSource, customError) in
            guard customError == nil else{
                print("\(customError?.localizedDescription)")
                return
            }
            
            guard let data_Source = dataSource else{
                print("Could Not load Table")
                return
            }
            
            
            DispatchQueue.main.async {
                self.schoolDirectoryTable.dataSource = data_Source
                self.schoolDirectoryTable.reloadData()
            }
        }
    }
}

