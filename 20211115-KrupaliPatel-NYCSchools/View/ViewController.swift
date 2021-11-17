//
//  ViewController.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var greetingLabel: UILabel!
    var schoolManager = SchoolsManager()
    @IBOutlet weak var listButton: UIButton!
    let dispatchGroup = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let listButtonTap = UITapGestureRecognizer(target: self, action:  #selector(self.handleListButtonTap(_:)))
        self.listButton.addGestureRecognizer(listButtonTap)
        self.listButton.layer.shadowOpacity = 0.5
        self.listButton.layer.cornerRadius = 5
        self.setGreetingMessage()
        //to use dummy json data set isDemo = true
        let isDemo = false
        self.activityIndicatorStart()
        //        DispatchQueue.global(qos: .userInitiated).async {
        self.fetchData(isDemo: isDemo)
        //        }
        
    }
    func updateUIOnNetworkCallCompletion(){
        self.schoolManager.didFinishFetch={(_ forValue: APIResponseType) in
            //            if(forValue == APIResponseType.schools){
            self.dispatchGroup.leave()
            self.activityIndicatorStop()
            //            }
        }
    }
    
    @objc func handleListButtonTap(_ sender: UITapGestureRecognizer? = nil) {
        performSegue(withIdentifier: "schoolTable", sender: self)
    }
    
    func setGreetingMessage(){
        //get hour int value and set greeting message
        let hour = Calendar.current.component(.hour, from: Date())
        var greetingText : String
        if hour >= 12 && hour <= 16 {
            greetingText = "Hello, Good Afternoon! \n Welcome to the NYC Schools app."
        }
        else if hour >= 7 && hour <= 12 {
            greetingText = "Hello, Good Morning!  \n Welcome to the NYC Schools app."
        }
        else if hour >= 16 && hour <= 20 {
            greetingText = "Hello, Good Evening!  \n Welcome to the NYC Schools app."
        }
        else{
            greetingText = "Hello, \n Welcome to the NYC Schools app!"
        }
        self.greetingLabel.text = greetingText
    }
    
    //MARK: API fetch
    func fetchData(isDemo: Bool){
        //set isDemo = true to view data from file. To call API set isDemo = false
        dispatchGroup.enter()
        self.schoolManager.fetchSchoolURL(isDemo: isDemo)
        dispatchGroup.enter()
        self.schoolManager.fetchSchoolSATURL(isDemo: isDemo)
        self.updateUIOnNetworkCallCompletion()
        dispatchGroup.notify(queue: .main){
            if(self.activityIndicator.isAnimating){
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    //    //MARK: Activity Indicator
    func activityIndicatorStart(){
        self.listButton.isHidden = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func activityIndicatorStop(){
        DispatchQueue.main.async { [unowned self] in
            self.listButton.isHidden = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "schoolTable"){
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! SchoolListTableViewController
            dest.schoolManager = schoolManager
            
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "SchoolListTableView") as! SchoolListTableViewController
            navigationController?.pushViewController(destination, animated: true)
            destination.schoolManager = schoolManager
        }
    }
}

