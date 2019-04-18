//
//  ViewController.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/17/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import UIKit


class NYCSchoolHomeViewController: UIViewController , NYCSchoolDataSourceDelegate{
    @IBOutlet weak var schoolDirectoryTable: UITableView!
    
    var managerNYCSchool = NYCSchoolManager()
    var nycScgooldata : NYCSchoolDiretoryDataSource?
    var selectedSatDataVM : NYCSchoolSATViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NYC School List"

        
        var directoryVMList : [NYCSchoolDirectoryViewModelProtocol]?
        var satDataVMList : [NYCSchoolSATViewModelProtocol]?
       
        
        DispatchQueue.global(qos: .userInitiated).async {
            var storedError: NSError?
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            self.managerNYCSchool.getSchoolDirectoryList { (directoryViewModalArray, customError) in
                guard customError == nil else{
                    print("\(String(describing: customError?.localizedDescription))")
                    return
                }
                guard let directory_ViewModalArray = directoryViewModalArray else{
                    print("Could Not load Table")
                    return
                }
                directoryVMList = directory_ViewModalArray
                downloadGroup.leave()
            }
            downloadGroup.enter()
            self.managerNYCSchool.getSatDataList { (satViewModalArray, error) in
                guard error == nil else{
                    print("\(String(describing: error?.localizedDescription))")
                    return
                }
                guard let satVMArray = satViewModalArray else{
                    print("Could Not load Table")
                    return
                }
                satDataVMList = satVMArray
                downloadGroup.leave()
            }
            downloadGroup.notify(queue: DispatchQueue.main) {
                print("")
                self.managerNYCSchool.getDataSourceForTableView(withDirectoryVMList: directoryVMList ?? [], withSATVMList: satDataVMList ?? [], completionHandler: { (data_source, error) in
                    DispatchQueue.main.async {
                        self.nycScgooldata = data_source
                        self.nycScgooldata?.delegate = self
                        self.schoolDirectoryTable.dataSource =  self.nycScgooldata
                        self.schoolDirectoryTable.delegate =  self.nycScgooldata
                        self.schoolDirectoryTable.reloadData()
                    }
                })
            }
        }
    }
    
    func getSatDataOnCellSelection(satData: NYCSchoolSATViewModelProtocol?) {
        
        DispatchQueue.main.async {
            if satData == nil{
                let alertController = UIAlertController(title: "Alert", message: "No Data Found.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction) in
                    print("You've pressed cancel");
                }
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }else{
                self.selectedSatDataVM = satData
                self.performSegue(withIdentifier: "ShowSATData", sender: self)
            }
           
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSATData"{
            if let nextController = segue.destination as? NYCSchoolSATDataViewController, self.selectedSatDataVM != nil{
                nextController.selectedSatDataVM = self.selectedSatDataVM
                
            }
        }
    }
}

