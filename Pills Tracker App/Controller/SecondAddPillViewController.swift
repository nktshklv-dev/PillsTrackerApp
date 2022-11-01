//
//  SecondAddPillViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/18/22.
//

import UIKit

class SecondAddPillViewController: UIViewController {
    
    var selectedPicture: String = ""
    var selectedTabletName: String = ""
    var selectedTabletDose: String = ""
    var selectedTabletTimestamp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(previousVC), for: .touchUpInside)
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "closeButton2"), for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        print("------")
        print(selectedPicture)
        print(selectedTabletDose)
        print(selectedTabletName)
        print(selectedTabletTimestamp)
        initialise()
    }
    
    @objc func previousVC(){
        navigationController?.popViewController(animated: true)
    }
    @objc func closeVC(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    func initialise(){
        let pageNumberLabel = UILabel()
        pageNumberLabel.text = "2 is 2"
        pageNumberLabel.font = UIFont.systemFont(ofSize: 16)
        pageNumberLabel.textColor = UIColor(named: "Gray 1")
        view.addSubview(pageNumberLabel)
        pageNumberLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(24)
            make.top.equalTo(view.snp.top).offset(100)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Schedule"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.textColor = UIColor(named: "Dark")
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(pageNumberLabel)
            make.top.equalTo(pageNumberLabel.snp.bottom).offset(12)
            
            
        
        }
        
    }
   

}
