//
//  NYCSchoolSATDataViewController.swift
//  20190417-SudhirKumar-NYCSchools
//
//  Created by Sudhir Kumar on 4/18/19.
//  Copyright © 2019 Sudhir Kumar. All rights reserved.
//

import UIKit

class NYCSchoolSATDataViewController: UIViewController {
    
    @IBOutlet weak var noOfTakerLabel: UILabel!
    @IBOutlet weak var readingAvgLabel: UILabel!
    @IBOutlet weak var mathAvgLabel: UILabel!
    @IBOutlet weak var writingAvgLabel: UILabel!
    
    var selectedSatDataVM : NYCSchoolSATViewModelProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = selectedSatDataVM?.school_name
        self.noOfTakerLabel.text = selectedSatDataVM?.num_of_sat_test_takers
        self.readingAvgLabel.text = selectedSatDataVM?.sat_critical_reading_avg_score
        self.mathAvgLabel.text = selectedSatDataVM?.sat_math_avg_score
        self.writingAvgLabel.text = selectedSatDataVM?.sat_writing_avg_score
        
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
