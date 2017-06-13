//
//  FirstViewController.swift
//  GifteryDemo
//
//  Created by Saurabh Yadav on 14/06/17.
//  Copyright © 2017 Saurabh Yadav. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var firstTableVIew: UITableView!
    var homeDataViewModel: [FirstModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstTableVIew.delegate = self
        self.firstTableVIew.dataSource = self
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    
    func getData(){
        let data = RequestManager.shared.returnJsonContents(filename: "json", fileExtension: "json")
        if data == nil{
            // show some error and return
            return
        }
        if let gotArray = data as? [Any] {
            homeDataViewModel = FirstModel.modelsFromDictionaryArray(array: gotArray as! [[String : Any]])
            self.firstTableVIew.reloadData()
        }else{
            // file reading error
            // handle here
            }
        }
}

extension FirstViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeDataViewModel!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.firstTableVIew.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell{
            if let data = self.homeDataViewModel?[indexPath.section] {
                cell.homeModel = data
                cell.configData()
            }
        return cell
        }else {
            let cell = self.firstTableVIew.dequeueReusableCell(withIdentifier: "FirstTableViewCell") as? FirstTableViewCell
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.height, height: 10))
        view.backgroundColor = .clear
        return view
    }
    
}
