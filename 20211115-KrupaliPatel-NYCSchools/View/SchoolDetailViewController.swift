//
//  SchoolDetailViewController.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

import UIKit


class SchoolDetailViewController : UIViewController{
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolOverViewTable: UITableView!
    
    var schoolSATDetails : NYCSchoolSATStruct? = nil
    var schoolInfo : NYCSchoolStruct? = nil
    
    override func viewDidLoad() {
        schoolOverViewTable.delegate = self
    }
}

extension SchoolDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let satScoreTableCell = tableView.dequeueReusableCell(withIdentifier: "SATScoreTableCell") as! SATScoreTableCell
//            satScoreTableCell.schoolSATDetails = self.schoolSATDetails
            satScoreTableCell.schoolNameLabel.text = schoolSATDetails?.school_name ?? ""
            satScoreTableCell.readScoreLabel.text = "SAT Average Reading Score: " + (schoolSATDetails?.sat_critical_reading_avg_score ?? "-")
            satScoreTableCell.mathScoreLabel.text = "SAT Average Math Score: " + (schoolSATDetails?.sat_math_avg_score ?? "-")
            satScoreTableCell.writeScoreLabel.text = "SAT Average Writing Score: " + (schoolSATDetails?.sat_writing_avg_score ?? "-")
            return satScoreTableCell
        }
        else if(indexPath.row == 1){
            let overViewTableCell = tableView.dequeueReusableCell(withIdentifier: "OverViewCell") as! OverviewTableCell
            overViewTableCell.overview.text = self.schoolInfo?.overview_paragraph
            return overViewTableCell
        }
        else if(indexPath.row == 2){
            let contactInfoCell = tableView.dequeueReusableCell(withIdentifier: "ContactInfoTableCell") as! ContactInfoTableCell
            contactInfoCell.address.text = UtilityFunctions.addressCleaner(self.schoolInfo?.location) 
            contactInfoCell.phone.text = self.schoolInfo?.phone_number
            contactInfoCell.webSite.text = self.schoolInfo?.website
            return contactInfoCell
        }
        else if(indexPath.row == 3){
            let addressInfoCell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell") as! AddressTableViewCell
            guard UtilityFunctions().getLocationForMapKit(schoolAddress: self.schoolInfo?.location) != nil
            else{
                return addressInfoCell
            }
            
            addressInfoCell.displayHighSchoolAddressOnMap(UtilityFunctions().getLocationForMapKit(schoolAddress: self.schoolInfo?.location)!)
            return addressInfoCell
        }
        else{
            return UITableViewCell()
        }
    }
    
    
    
}
