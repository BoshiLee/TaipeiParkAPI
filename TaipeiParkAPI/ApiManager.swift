//
//  JsonParser.swift
//  TaipeiParkAPI
//
//  Created by Boshi Li on 16/03/2017.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit

typealias ParkEntity = (parkName:String, landmarks:[LandmarkDetail])
typealias Parks = [ParkEntity]

struct LandmarkDetail {
    let parkName : String
    let name : String
    let openTime: String
    let imageURL: URL?
    let introduction: String
    
}


class ApiManager {
    static let shared = ApiManager()
    var imgURL: (String?) -> URL? = {
        var url: URL?
        if let fileExtension = $0?.substring(from:($0?.index(($0?.endIndex)!, offsetBy: -3))!){
            if fileExtension == "JPG" ||
                fileExtension == "jpg" ||
                fileExtension == "png"
            {
                return URL(string: $0!)
            }
        }
        return url
    }
    
    var apiData: () -> Data? =  {
        let bundle = Bundle.main.url(forResource: "apiIn", withExtension: "json")
        do {
            let data = try Data(contentsOf: bundle!)
            return data
        }
        catch {
            Errors.message("Failed to load Api Data!").handler()
            //Error.retrieve(.message("Failed to load Api Data!"))
        }
        return nil

    }

    func praseJson(from data: () -> Data?, errorHandeler: @escaping (Errors) -> Void, completion: @escaping (Parks) -> Void) {
        var parks = Parks()
        var parkEntity = ParkEntity("", [])
        var parkNameIndex = 0
        
        func appendNewEntityToParks(with parkName: String, and landmark: LandmarkDetail) {
            parkEntity.landmarks = []
            parkEntity.parkName = parkName
            parkEntity.landmarks.append(landmark)
            parks.append(parkEntity)
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data()!, options: .allowFragments) else {
            errorHandeler(.message("Data is not a json format"))
            return
        }
        guard let parkObject = jsonObject as? [AnyObject]
            else {
            errorHandeler(.message("casting object failed"))
            return
        }
        for (ix, element) in parkObject.enumerated()
        {
            if let entity = element as? [String:String] {
                let parkName = entity["ParkName"]!
                let name = entity["Name"]!
                let openTime = entity["OpenTime"]!
                let imageURL = imgURL(entity["Image"]!)
                let introduction = entity["Introduction"]!
                let landMark = LandmarkDetail(parkName: parkName,name: name, openTime: openTime, imageURL: imageURL, introduction: introduction)
                if parks.isEmpty
                {
                    appendNewEntityToParks(with: parkName, and: landMark)
                }
                else if ix != 0 ,parks[parkNameIndex].parkName == parkName
                {
                    parks[parkNameIndex].landmarks.append(landMark)
                } else {
                    appendNewEntityToParks(with: parkName, and: landMark)
                    parkNameIndex += 1
                }
            }
        }
        completion(parks)
    } 
}
