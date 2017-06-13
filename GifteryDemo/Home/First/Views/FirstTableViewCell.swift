//
//  FirstTableViewCell.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 14/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var paddedView: UIView!
    @IBOutlet weak var centerYConstraintForName: NSLayoutConstraint!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var occasionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noOfDaysLabel: UILabel!
    
    @IBOutlet weak var tickImageView: UIImageView!
    @IBOutlet weak var giftLabel: UILabel!
    
    var homeModel: FirstModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        giftLabel.layer.cornerRadius = 15
        giftLabel.clipsToBounds = true
        self.paddedView.addShadowView()
        
    }
    
    func configData(){
        if homeModel?.name == "" || homeModel?.name == nil{
            centerYConstraintForName.constant = 0
            personNameLabel.text = homeModel?.occasion
            occasionLabel.isHidden = true
        }else{
            centerYConstraintForName.constant = -15.75
            personNameLabel.text = homeModel?.name
            occasionLabel.text = homeModel?.occasion
            occasionLabel.isHidden = false
        }
        
        noOfDaysLabel.text = homeModel?.remainingDays
        noOfDaysLabel.textColor = UIColor.init(hex: (homeModel?.dateColor)!)
        dateLabel.text = homeModel?.date?.uppercased()
        
        if (homeModel?.gifted)!{
            giftLabel.text = ""
            tickImageView.isHidden = false
            self.paddedView.backgroundColor = UIColor.init(hex: "dad2d5")
            
        }else{
            giftLabel.text = "GIFT"
            tickImageView.isHidden = true
        }
        
    }

}
