//
//  ViewController.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 13/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    struct ContainerControllerSelector {
        var currentIndex = 0
        var PreviousIndex = -1
    }
    
    @IBOutlet weak var gifterimageSuperview: UIView!
    @IBOutlet weak var tabsContainerView: UIView!
    @IBOutlet weak var bottomBarView: BottomBarView!
    @IBOutlet weak var giftImageView: UIImageView!
    
    @IBOutlet weak var eventsButton: UIButton!{
        didSet {
            eventsButton.tag = 0
            eventsButton.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var ordersButton: UIButton!{
        didSet {
            ordersButton.tag = 1
            ordersButton.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var giftsButton: UIButton!{
        didSet {
            giftsButton.tag = 2
            giftsButton.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
        }
    }
    @IBOutlet weak var meButton: UIButton!{
        didSet {
            meButton.tag = 3
            meButton.addTarget(self, action: #selector(selectedButton(sender:)), for: .touchUpInside)
        }
    }
    
    var indexTracker = ContainerControllerSelector()
    var currentControllerTag = 0
    var imageView = UIImageView()
    
    lazy var firstController: FirstViewController? = {
        let controller = EnumStoryboards.first.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController
        
        return controller
    }()
    
    lazy var secondController: SecondViewController? = {
        let controller = EnumStoryboards.second.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        return controller
        
    }()
    
    lazy var thirdController: ThirdViewController? = {
        let controller = EnumStoryboards.third.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController
        return controller
        
    }()
    
    lazy var fourthController: FourthViewController? = {
        let controller = EnumStoryboards.fourth.instantiateViewController(withIdentifier: "FourthViewController") as? FourthViewController
        return controller
        
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Events"
        self.add(asChildViewController: firstController!)
        self.setSelectedForButtons(index: 0)
        self.setGestureOnImage()
        self.setNavigationBarTraits()
    }
    
    func setNavigationBarTraits(){
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir Next", size: 15)!]
        let titleColorDict = [NSForegroundColorAttributeName: UIColor.init(hex: "8c6b74")]
        self.navigationController?.navigationBar.titleTextAttributes = titleColorDict
    }
    private func setGestureOnImage(){
        let singleTap = UITapGestureRecognizer.init(target: self, action: #selector(singleTapping(recognizer:)))
        singleTap.numberOfTapsRequired = 1
        gifterimageSuperview.addGestureRecognizer(singleTap)
        
        let longTap = UILongPressGestureRecognizer.init(target: self, action: #selector(darkenImage(sender:)))
        longTap.minimumPressDuration = 0.1
        gifterimageSuperview.addGestureRecognizer(longTap)
        
        giftImageView.image = giftImageView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    }
    
    
    func singleTapping(recognizer: UIGestureRecognizer) {
        print("image clicked")
        if (recognizer.state == .ended){
            self.giftImageView.layer.opacity = 1.0
            giftImageView.tintColor = UIColor.white
            self.showGiftController()
        }
    }
    
    
    func darkenImage(sender: UIGestureRecognizer){
        
        if sender.state == .changed{
            self.giftImageView.layer.opacity = 0.9
            giftImageView.tintColor = UIColor.darkGray
            
        }else if (sender.state == .ended){
            self.giftImageView.layer.opacity = 1.0
            giftImageView.tintColor = UIColor.white
            self.showGiftController()
        }
    }
    
    private func removeChildViews(){
        
        switch currentControllerTag {
        case 0:
            self.removeController(viewController: secondController)
            self.removeController(viewController: thirdController)
            self.removeController(viewController: fourthController)
        case 1:
            self.removeController(viewController: firstController)
            self.removeController(viewController: thirdController)
            self.removeController(viewController: fourthController)
        case 2:
            self.removeController(viewController: firstController)
            self.removeController(viewController: secondController)
            self.removeController(viewController: fourthController)
        case 3:
            self.removeController(viewController: secondController)
            self.removeController(viewController: thirdController)
            self.removeController(viewController: firstController)
        default:
            break
        }
        
    }
    
    private func removeController(viewController: UIViewController?) {
        viewController?.willMove(toParentViewController: self)
        // Remove Child View From Superview
        viewController?.view.removeFromSuperview()
        // Notify Child View Controller
        viewController?.removeFromParentViewController()
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        if indexTracker.PreviousIndex == currentControllerTag{
            return
        }
        // Add Child View Controller
        addChildViewController(viewController)
        // Add Child View as Subview
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        transition.type = kCATransitionPush
        transition.duration = 0.2
        if currentControllerTag < self.indexTracker.PreviousIndex{
            transition.subtype = kCATransitionFromLeft
        }else{
            transition.subtype = kCATransitionFromRight
        }
        
        self.tabsContainerView.layer.add(transition, forKey: nil)
        self.tabsContainerView.addSubview(viewController.view)
        // Configure Child View
        viewController.view.frame = self.tabsContainerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
        indexTracker.PreviousIndex = currentControllerTag
        
        //        remove others
        self.removeChildViews()
    }
    
    internal func selectedButton(sender: UIButton) {
        print(index)
        currentControllerTag = sender.tag
        self.setSelectedForButtons(index: sender.tag)
        switch  sender.tag {
        case 0:
            self.add(asChildViewController: firstController!)
            self.title = "Your Events"
        case 1:
            self.add(asChildViewController: secondController!)
            self.title = "Orders"
        case 2:
            self.add(asChildViewController: thirdController!)
            self.title = "Gifts"
        case 3:
            self.add(asChildViewController: fourthController!)
            self.title = "Me"
        default:
            break
        }
    }
    
    func setSelectedForButtons(index: Int){
        if eventsButton.tag != index{
            eventsButton.isSelected = false
        } else {
            eventsButton.isSelected = true
        }
        if ordersButton.tag != index{
            ordersButton.isSelected = false
        }else{
            ordersButton.isSelected = true
        }
        if meButton.tag != index{
            meButton.isSelected = false
        }else {
            meButton.isSelected = true
        }
        if giftsButton.tag != index{
            giftsButton.isSelected = false
        } else {
            giftsButton.isSelected = true
        }
        
    }
    
    func showGiftController(){
        currentControllerTag = 2
        self.setSelectedForButtons(index: 2)
        self.title = "Gifts"
        self.add(asChildViewController: thirdController!)
    }
}

