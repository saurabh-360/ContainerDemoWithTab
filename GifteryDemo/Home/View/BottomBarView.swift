//
//  BottomBarView.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 13/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit

protocol ButtonSelectorDelegate {
    func selectedButton(atIndex index: Int)
}
class BottomBarView: UIView {
    @IBOutlet var bottomBarView: UIView!
    var delegate: ButtonSelectorDelegate?

    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var eventsButton: UIButton!{
        didSet {
            eventsButton.tag = 0
            eventsButton.addTarget(self, action: #selector(selecteButton(sender:)), for: .touchUpInside)
//            eventsButton?.imageView?.backgroundColor = .orange

        }
    }
    @IBOutlet weak var ordersButton: UIButton!{
        didSet {
            ordersButton.tag = 1
            ordersButton.addTarget(self, action: #selector(selecteButton(sender:)), for: .touchUpInside)
//            ordersButton?.imageView?.backgroundColor = .orange

        }
    }
    @IBOutlet weak var giftsButton: UIButton!{
        didSet {
            giftsButton.tag = 2
            giftsButton.addTarget(self, action: #selector(selecteButton(sender:)), for: .touchUpInside)
            giftsButton?.imageView?.frame = CGRect.init(origin: giftsButton.frame.origin, size: CGSize.init(width: 100, height: 100))
            giftsButton?.imageEdgeInsets = UIEdgeInsetsMake(20,20,20,20)

            giftsButton?.imageView?.backgroundColor = .green
            giftsButton?.imageView?.layer.cornerRadius = (giftsButton?.imageView?.frame.size.height)!/2

        }
    }
    @IBOutlet weak var meButton: UIButton!{
        didSet {
            meButton.tag = 3
            meButton.addTarget(self, action: #selector(selecteButton(sender:)), for: .touchUpInside)
//            meButton?.imageView?.backgroundColor = .orange

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        Bundle.main.loadNibNamed("BottomBarView", owner: self, options: nil)
        self.addSubview(bottomBarView)
        bottomBarView.frame = self.bounds
//        giftImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
        giftImageView.image = UIImage.init(named: "tabGiftery")
        giftImageView.image = giftImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        giftImageView.layer.cornerRadius = giftImageView.frame.size.width/2
        giftImageView.clipsToBounds = true
        giftImageView.backgroundColor = UIColor.init(hex: "85bcbd")
        giftImageView.isUserInteractionEnabled = true
        //
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(singleTapping(recognizer:)))
        
        singleTap.numberOfTapsRequired = 1
        giftImageView.addGestureRecognizer(singleTap)
        //
        
        
        let longTap = UILongPressGestureRecognizer.init(target: self, action: #selector(darkenImage(sender:)))
        //            [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(darkenImage)];
        longTap.minimumPressDuration = 0.1
        self.giftImageView.addGestureRecognizer(longTap)
        
        
    }

    func singleTapping(recognizer: UIGestureRecognizer) {
        print("image clicked")
        if (recognizer.state == .ended){
            self.giftImageView.layer.opacity = 1.0
            giftImageView.tintColor = UIColor.white
        }
    }
    
    
    func darkenImage(sender: UIGestureRecognizer){
        if sender.state == .possible{
            self.giftImageView.layer.opacity = 0.9
            giftImageView.tintColor = UIColor.blue
        }
        if sender.state == .changed{
            self.giftImageView.layer.opacity = 0.9
            giftImageView.tintColor = UIColor.blue
            
        }else if (sender.state == .ended){
            self.giftImageView.layer.opacity = 1.0
            giftImageView.tintColor = UIColor.white
        }
    }

    
    func selecteButton(sender: UIButton){
        switch sender.tag {
        case 0:
            eventsButton.isSelected = true
        default:
            break
        }
        self.delegate?.selectedButton(atIndex: sender.tag)
        
    }
}


class CenteredButton: UIButton
{
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.titleRect(forContentRect: contentRect)
        let imageRect = super.imageRect(forContentRect: contentRect)
        if self.tag == 2{
            return CGRect(x: 0, y: rect.height + 20,
                          width: contentRect.width, height: rect.height)
        }
        return CGRect(x: 0, y: imageRect.maxY - 10,
                      width: contentRect.width, height: rect.height)
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let rect = super.imageRect(forContentRect: contentRect)
        let titleRect = self.titleRect(forContentRect: contentRect)
        
        return CGRect(x: contentRect.width/2.0 - rect.width/2.0,
                      y: (contentRect.height - titleRect.height)/2.0 - rect.height/2.0,
                      width: rect.width, height: rect.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        centerTitleLabel()
    }
    
    private func centerTitleLabel() {
        self.titleLabel?.textAlignment = .center
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
