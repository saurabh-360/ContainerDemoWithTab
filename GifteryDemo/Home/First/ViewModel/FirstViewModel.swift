//
//  FirstViewModel.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 14/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit

struct FirstViewModel{
    var name: String?
    var occasion: String?
    var date: String?
    var gifted: Bool?
    
    init(firstModel: FirstModel) {
        if let name = firstModel.name{
            self.name = name
        }
        if let occasion = firstModel.occasion{
            self.occasion = occasion
        }
        if let date = firstModel.date{
            
            self.date = date
        }
        if let gifted = firstModel.gifted{
            self.gifted = gifted
        }
    }
}



//refer the question i answered once on stackoverflow
//https://stackoverflow.com/a/36753347/4549304

extension String{
    
    func relativeFuture(for date : Date) -> (date: String, dateColor: String) {
        
        let units = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second, .weekOfYear])
        let components = Calendar.current.dateComponents(units, from: Date(), to: date)
        var dateColor = "939598"
        
        if components.year! > 0 {
            return ("in \(components.year!) " + (components.year! > 1 ? "year" : "year"), dateColor)
            
        } else if components.month! > 0 {
            return ("in \(components.month!) " + (components.month! > 1 ? "months" : "month"), dateColor)
        } else {
            if components.day! > 15 {
                return ((components.day! > 0 ? "in \(components.day!) days" : "Past Event") , dateColor)
            } else{
                dateColor = "f58d89"
                return ((components.day! > 0 ? "in \(components.day!) days" : "Past Event") , dateColor)
            }
        }
//        } else if components.hour! > 0 {
//            return "\(components.hour!) " + (components.hour! > 1 ? "hours ago" : "hour ago")
//            
//        } else if components.minute! > 0 {
//            return "\(components.minute!) " + (components.minute! > 1 ? "minutes ago" : "minute ago")
//            
//        } else {
//            return "\(components.second!) " + (components.second! > 1 ? "seconds ago" : "second ago")
//        }
    }
}

