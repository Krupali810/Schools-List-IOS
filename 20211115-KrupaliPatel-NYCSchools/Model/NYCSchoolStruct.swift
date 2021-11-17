//
//  NYCSchoolStruct.swift
//  KrupaliPatel-NYCSchools
//
//  Created by Krupali Patel
//

struct NYCSchoolStruct : Decodable {
    let dbn : String
    let school_name : String
    let overview_paragraph : String?
    let neighborhood : String?
    let location: String?
    let phone_number: String?
    let fax_number: String?
    let school_email: String?
    let website: String?
    let subway: String?
    let bus: String?
    let finalgrades: String?
    let total_students: String?
    let extracurricular_activities: String?
    let attendance_rate: String?
    let city: String
    let zip: String?
    let state_code: String?
    let latitude: String?
    let longitude: String?
    let nta: String?
    let borough: String?
}



