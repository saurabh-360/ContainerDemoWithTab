//
//  Utility.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 14/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit


enum EnumStoryboards{
    static var first = UIStoryboard.init(name: "First", bundle: Bundle.main)
    static var second = UIStoryboard.init(name: "Second", bundle: Bundle.main)
    static var third = UIStoryboard.init(name: "Third", bundle: Bundle.main)
    static var fourth = UIStoryboard.init(name: "Fourth", bundle: Bundle.main)
}

extension UIView{
    func addShadowView(width:CGFloat=0.0, height:CGFloat=1.0,radius:CGFloat=4.0, Opacidade:Float=0.7, maskToBounds:Bool=false) {
        // corner radius
                self.layer.cornerRadius = 0
                self.layer.masksToBounds = maskToBounds
                self.layer.shadowOffset = CGSize(width: 1, height: -1)
                self.layer.shadowOpacity = 0.3
                self.layer.shadowRadius = 5.0
//                self.layer.masksToBounds = true
    }
}


extension Date
{
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        self = dateStringFormatter.date(from: dateString)!
    }
    
    //    2017-06-20
    private static let dateFormatterdd_MMMM_yyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    private static let dateFormatterdd_MMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    public var dd_mmm : String {
        return Date.dateFormatterdd_MMM.string(from: self)
    }
    
    public var yyyy_mm_dd : String {
        return Date.dateFormatterdd_MMMM_yyy.string(from: self)
    }
    
}
