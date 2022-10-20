//
//  AddPillViewController.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/18/22.
//

import UIKit
import SnapKit

class AddPillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIButton()
//        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "closeButton2"), for: .normal)
        closeButton.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        closeButton.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        
        initialise()

        
    }
    
    private func initialise(){
        let pageNumber = UILabel()
        pageNumber.text = "1 is 2"
        pageNumber.textColor = UIColor(named: "Gray 1")
        pageNumber.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(pageNumber)
        pageNumber.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(24)
            make.top.equalTo(view.snp.top).offset(100)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Add medication"
        titleLabel.textColor = UIColor(named: "Dark")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(pageNumber.snp.bottom).offset(12)
            make.left.equalTo(pageNumber.snp.left)
        }
        
        let pillButton = CustomButton()
        pillButton.image = "pill"
        view.addSubview(pillButton)
        pillButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(23.5)
            make.top.equalTo(titleLabel.snp.bottom).offset(45)
        }
        let capsuleButton = CustomButton()
        capsuleButton.image = "capsule"
        view.addSubview(capsuleButton)
        capsuleButton.snp.makeConstraints { make in
            make.left.equalTo(pillButton.snp.right).offset(24)
            make.top.equalTo(pillButton.snp.top)
        }
        let ampuleButton = CustomButton()
        ampuleButton.image = "ampule"
        view.addSubview(ampuleButton)
        ampuleButton.snp.makeConstraints { make in
            make.left.equalTo(capsuleButton.snp.right).offset(24)
            make.top.equalTo(pillButton.snp.top)
        }
        let ingButton = CustomButton()
        ingButton.image = "ing"
        view.addSubview(ingButton)
        ingButton.snp.makeConstraints { make in
            make.left.equalTo(ampuleButton.snp.right).offset(24)
            make.top.equalTo(pillButton.snp.top)
        }
        
        
        
        
        
        
        
        
    }
      
        
        
        
        
       
    
    
    
   
    
    
  
    @objc func closeVC(){
        navigationController?.popViewController(animated: true)
    }
    



}
