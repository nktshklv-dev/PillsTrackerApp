//
//  SecondAddPillViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/18/22.
//

import UIKit

class SecondAddPillViewController: UIViewController {

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
    }
    
    @objc func previousVC(){
        navigationController?.popViewController(animated: true)
    }
    @objc func closeVC(){
        navigationController?.popToRootViewController(animated: true)
    }
    

   

}
