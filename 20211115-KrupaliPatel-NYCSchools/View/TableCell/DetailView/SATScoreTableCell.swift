//
//  SATScoreTableCell.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

import UIKit

class SATScoreTableCell : UITableViewCell{
    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var readScoreLabel: UILabel!
    @IBOutlet var mathScoreLabel: UILabel!
    @IBOutlet var writeScoreLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
