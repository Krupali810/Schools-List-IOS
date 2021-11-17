//
//  AddressTableViewCell.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//
import UIKit
import MapKit

class AddressTableViewCell : UITableViewCell{
    @IBOutlet var addressMapView : MKMapView!
    
    override func awakeFromNib(){
        super.awakeFromNib()
    }
    
    func displayHighSchoolAddressOnMap(_ schoolCoordinates: CLLocationCoordinate2D){
        
        let schoolAnnotation = MKPointAnnotation()
        schoolAnnotation.coordinate = schoolCoordinates
        self.addressMapView.addAnnotation(schoolAnnotation)
        let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: schoolAnnotation.coordinate, span: span)
        let adjustRegion = self.addressMapView.regionThatFits(region)
        self.addressMapView.setRegion(adjustRegion, animated:true)
    }
}
