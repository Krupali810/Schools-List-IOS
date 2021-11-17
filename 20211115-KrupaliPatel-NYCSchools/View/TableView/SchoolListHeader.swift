//
//  SchoolListHeader.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

protocol SchoolListHeaderDelegate {
    func sortColumn(forName: String, header: SchoolListHeader)
}

import UIKit

class SchoolListHeader : UITableViewHeaderFooterView {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    
    @IBOutlet weak var schoolViewSortImage: UIImageView!
    @IBOutlet weak var locationViewSortImage: UIImageView!
    
    @IBOutlet weak var schoolView: UIView!
    @IBOutlet weak var locationView: UIView!
    
    var headerDelegate : SchoolListHeaderDelegate?
    var isAscending = true //flag to determine sort order
    
    let sortAscendingImage = UIImage(systemName: "arrowtriangle.up.fill")
    let sortDescendingImage = UIImage(systemName: "arrowtriangle.down.fill")
    let sortNoneImage = UIImage(systemName: "arrow.up.and.down")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let schoolSortViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSchoolSortViewTap(_:)))
        
        let locationSortViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleLocationSortViewTap(_:)))
         
        self.schoolView.addGestureRecognizer(schoolSortViewTap)
        self.locationView.addGestureRecognizer(locationSortViewTap)
    }

    
    @objc func handleSchoolSortViewTap(_ sender: UITapGestureRecognizer? = nil){
        self.isAscending = !isAscending
        self.locationViewSortImage.image = sortNoneImage
        if(isAscending){
            self.schoolViewSortImage.image = sortAscendingImage
        }else{
            self.schoolViewSortImage.image = sortDescendingImage
        }
        self.headerDelegate?.sortColumn(forName: tableHeaderTitleConstant.schoolHeaderTitle, header: self)
    }
    
    @objc func handleLocationSortViewTap(_ sender: UITapGestureRecognizer? = nil){
        self.isAscending = !isAscending
        self.schoolViewSortImage.image = sortNoneImage
        if(isAscending){
            self.locationViewSortImage.image = sortAscendingImage
        }else{
            self.locationViewSortImage.image = sortDescendingImage
        }
        self.headerDelegate?.sortColumn(forName: tableHeaderTitleConstant.locationHeaderTitle, header: self)
    }
}
