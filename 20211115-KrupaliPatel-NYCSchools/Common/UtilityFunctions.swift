//
//  UtilityFunctions.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel 
//

import Foundation
import CoreLocation


class UtilityFunctions {
    func getLocationForMapKit(schoolAddress: String?) -> CLLocationCoordinate2D?{
        if let schoolAddress = schoolAddress{
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates{
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
    
    static func addressCleaner(_ address: String?) -> String{
        if let address = address{
            let address = address.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    
}

extension String {
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
