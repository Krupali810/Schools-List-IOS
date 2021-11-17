//
//  SchoolsManager.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

import Foundation

enum APIResponseType{
    case schools
    case sat
}

class SchoolsManager{
    var schoolModelArray = [NYCSchoolStruct]()
    var schoolSATModelArray = [NYCSchoolSATStruct]()
    var didFinishFetch: ((_ forValue: APIResponseType) -> ())?
    var schoolDataModelArray : [NYCSchoolStruct]?{
        didSet{
            self.didFinishFetch?(.schools)
        }
    }
    var satDataModelArray : [NYCSchoolSATStruct]?{
        didSet{
            self.didFinishFetch?(.sat)
        }
    }
    
    func fetchSchoolURL(isDemo: Bool){
        if(isDemo){
            let filename = "NYCSchoolData"
            fetchSchoolInfo(filename, isDemo: isDemo)
        }else{
            let urlSchoolInfo = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
            fetchSchoolInfo(urlSchoolInfo, isDemo: isDemo)
        }
    }
    
    func fetchSchoolSATURL(isDemo : Bool){
        if(isDemo){
            let filename = "NYCSchoolSATData"
            fetchSchoolSATInfo(filename, isDemo: isDemo)
        }else{
            let urlSchoolSATInfo = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
            fetchSchoolSATInfo(urlSchoolSATInfo, isDemo : isDemo)
        }
    }
    
    func parseSchoolInfo(data: Data){
        self.schoolModelArray = try! JSONDecoder().decode([NYCSchoolStruct].self, from: data)
        self.schoolDataModelArray = schoolModelArray
    }
    
    func parseSchoolSATInfo(data: Data){
        self.schoolSATModelArray = try! JSONDecoder().decode([NYCSchoolSATStruct].self, from: data)
        self.satDataModelArray = schoolSATModelArray
    }
    
    func fetchSchoolInfo(_ urlString: String, isDemo : Bool){
        if(isDemo){
            //read data from file
            if let path = Bundle.main.path(forResource: urlString, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                    parseSchoolInfo(data: data)
                } catch {
                    // handle error
                }
            }
        }
        else{
            //call API
            self.didFinishFetch?(.schools)
            //1. Create a URL
            if let url = URL(string: urlString){
                //2. Create a Session
                let session = URLSession(configuration: .default)
                
                //3. Give Session a Task
                let task = session.dataTask(with: url) {
                    (data, response, error) in
                    if error != nil{
                        return
                    }
                    if let safeData = data {
                        self.parseSchoolInfo(data: safeData)
                    }
                }
                //4. Start Task
//                self.didFinishFetch?(.schools)
                task.resume()
            }
        }
    }
    

    
    func fetchSchoolSATInfo(_ urlString: String, isDemo : Bool){
        if(isDemo){
            //read data from file
            if let path = Bundle.main.path(forResource: urlString, ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
//                    schoolSATModelArray = try! JSONDecoder().decode([NYCSchoolSATStruct].self, from: data)
                    parseSchoolSATInfo(data: data)
                    
                } catch {
                    // handle error
                }
            }
        }
        else{
            //call API
            //1. Create a URL
            if let url = URL(string: urlString){
                //2. Create a Session
                let session = URLSession(configuration: .default)
                
                //3. Give Session a Task
                let task = session.dataTask(with: url) { (data, response, error) in
                    if error != nil{
                        return
                    }
                    if let safeData = data {
                        self.parseSchoolSATInfo(data: safeData)
                    }
                }
                //4. Start Task
//                self.didFinishFetch?(.sat)
                task.resume()
            }
        }
    }
}

