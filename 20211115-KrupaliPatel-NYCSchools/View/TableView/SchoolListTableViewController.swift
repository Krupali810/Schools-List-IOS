//
//  SchoolListTableViewController.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

import UIKit


class SchoolListTableViewController : UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    
    var schoolManager : SchoolsManager?
    var schoolList : [NYCSchoolStruct]?
    var filteredSchoolList : [NYCSchoolStruct]?
    var selectedIndexPathRow : Int?
    var selectedSchoolRecord : NYCSchoolStruct?
    var selectedSchoolSATRecordArray : [NYCSchoolSATStruct]?
    var selectedSchoolSATRecord : NYCSchoolSATStruct?
    var schoolSATArray : [NYCSchoolSATStruct]?
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchController = UISearchController()
    
    @IBOutlet var schoolTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.schoolTableView.delegate = self
        schoolList = schoolManager?.schoolModelArray
        schoolSATArray = schoolManager?.schoolSATModelArray
        filteredSchoolList = schoolManager?.schoolModelArray
        
        let nib = UINib(nibName: "SchoolListHeader", bundle: nil)
        schoolTableView.register(nib, forHeaderFooterViewReuseIdentifier: "SchoolListHeader")
        
        self.setupSearchBarOptions()
        
    }
    
    
    func setupSearchBarOptions(){
        self.searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.obscuresBackgroundDuringPresentation = true
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "School Name"
            controller.searchBar.delegate = self
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredSchoolList = schoolList
        self.schoolTableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text != nil {
            if(searchController.searchBar.text != ""){
                filteredSchoolList = schoolList?.filter({$0.school_name.localizedCaseInsensitiveContains(searchController.searchBar.text!)})
                self.schoolTableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.schoolTableView.dequeueReusableHeaderFooterView(withIdentifier: "SchoolListHeader") as! SchoolListHeader
        headerView.headerDelegate = self as SchoolListHeaderDelegate
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.filteredSchoolList?.count ?? 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolListCell", for: indexPath) as! SchoolListTableViewCell
        cell.schoolCityLabel.text = self.filteredSchoolList?[indexPath.row].city
        cell.schoolNameLabel.text = self.filteredSchoolList?[indexPath.row].school_name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPathRow = indexPath.row
        self.selectedSchoolRecord = self.filteredSchoolList?[indexPath.row]
        self.selectedSchoolSATRecordArray =  self.schoolSATArray?.filter({$0.dbn.contains(self.selectedSchoolRecord!.dbn)})
        
        if(self.selectedSchoolSATRecordArray != nil ){
            if(self.selectedSchoolSATRecordArray!.count > 0){
                self.selectedSchoolSATRecord = self.selectedSchoolSATRecordArray![0]
            }
        }
        performSegue(withIdentifier: "schoolDetail", sender: self)
    }
    
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if(identifier == "schoolDetail"){
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "SchoolDetailViewController") as! SchoolDetailViewController
            destination.schoolSATDetails = self.selectedSchoolSATRecord
            destination.schoolInfo = self.selectedSchoolRecord
            navigationController?.pushViewController(destination, animated: true)
        }
    }
}

//extension to implement header delegate
extension SchoolListTableViewController : SchoolListHeaderDelegate {
    //sort implemention
    func sortColumn(forName: String, header: SchoolListHeader) {
        if forName == tableHeaderTitleConstant.schoolHeaderTitle{
            //sort on school name
            if(header.isAscending){
                filteredSchoolList = filteredSchoolList?.sorted(by: {$0.school_name < $1.school_name})
            }else{
                filteredSchoolList = filteredSchoolList?.sorted(by: {$0.school_name > $1.school_name})
            }
        }else if forName == tableHeaderTitleConstant.locationHeaderTitle{
            //sort on location
            //sort on school name
            if(header.isAscending){
                filteredSchoolList = filteredSchoolList?.sorted(by: {$0.city < $1.city})

            }else{
                filteredSchoolList = filteredSchoolList?.sorted(by: {$0.city > $1.city})
            }
        }
        self.tableView.reloadData()
    }
}
