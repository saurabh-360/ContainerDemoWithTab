//
//  FirstModel.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 14/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import Foundation

public class FirstModel {
    public var name : String?
    public var occasion : String?
    public var date : String?
    public var remainingDays : String?
    public var gifted : Bool?
    public var dateColor = "939598"
    
    public class func modelsFromDictionaryArray(array: [[String: Any]]?) -> [FirstModel]?
    {
        var models:[FirstModel] = []
        for item in array!
        {
            models.append(FirstModel(dictionary: item)!)
        }
        return models
    }
    
    required public init?(dictionary: [String: Any]?) {
        
        
        name = dictionary?["Name"] as? String
        occasion = dictionary?["Occasion"] as? String
        
        if let stringDate = dictionary?["Date"] as? String{
            let date_Date = Date.init(dateString: stringDate)
            let dateTuple = stringDate.relativeFuture(for: date_Date)
            remainingDays = dateTuple.date
            dateColor = dateTuple.dateColor
            date = date_Date.dd_mmm

            
        }else{
            remainingDays = ""
            dateColor = "001243"
        }
        if let stringDate = dictionary?["Date"] as? String{
            
            let date_Date = Date.init(dateString: stringDate)
        }
        
        
        if let isGifted = dictionary?["Gifted"] as? String{
            if isGifted == "TRUE"{
                gifted = true
            }else{
                gifted = false
            }
        }
    }
}



