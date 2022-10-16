//
//  GetVaccinatedView.swift
//  Pills Tracker App
//
//  Created by Nikita  on 10/12/22.
//

import Foundation
import UIKit
import SnapKit


func createGetVaccinatedview() -> UIView{
    let maskView = UIView()
    maskView.clipsToBounds = true
    maskView.layer.cornerRadius = 24
    
    
    let backgroundGradient = UIImageView()
    backgroundGradient.image = UIImage(named: "getVaccinatedViewGRADIENT")
    
    let backgroundView = UIView()
    backgroundView.clipsToBounds = true
    backgroundView.frame.size.width = 327
    backgroundView.frame.size.height = 88
    backgroundView.layer.cornerRadius = 24
    backgroundView.backgroundColor = UIColor(named: "getVaccinatedViewBG")
    
    backgroundView.addSubview(backgroundGradient)
    backgroundGradient.snp.makeConstraints { make in
        make.left.right.top.bottom.equalTo(backgroundView)
    }
    
    
    
    maskView.addSubview(backgroundView)
    backgroundView.snp.makeConstraints { make in
        make.bottom.left.right.equalTo(maskView)
    }
    
    //create mask
    let syringeImage = UIImageView()
    syringeImage.image = UIImage(named: "syringeImage")
    syringeImage.contentMode = .scaleAspectFit
    maskView.addSubview(syringeImage)
    
    
    syringeImage.snp.makeConstraints { make in
        make.bottom.equalTo(backgroundView.snp.bottom)
        make.right.equalTo(backgroundView.snp.right)
    }
    
    let mainLabel = UILabel()
    mainLabel.text = "Get vaccinated"
    mainLabel.font = UIFont.boldSystemFont(ofSize: 24)
    mainLabel.textColor = .white
    backgroundView.addSubview(mainLabel)
    mainLabel.snp.makeConstraints { make in
        make.top.equalTo(maskView.snp.top).offset(33)
        make.left.equalTo(maskView.snp.left).offset(24)
    }
    
    let secondLabel = UILabel()
    secondLabel.text = "Nearest vaccination center"
    secondLabel.font = UIFont.systemFont(ofSize: 16)
    secondLabel.textColor = .white
    backgroundView.addSubview(secondLabel)
    secondLabel.snp.makeConstraints { make in
        make.left.equalTo(maskView.snp.left).offset(24)
        make.top.equalTo(maskView.snp.top).offset(61)
    }
    
    let closeButton = UIButton()
    closeButton.setImage(UIImage(named: "closeButton"), for: .normal)
    closeButton.contentMode = .scaleAspectFit
    maskView.addSubview(closeButton)
    closeButton.snp.makeConstraints { make in
        make.right.equalTo(maskView.snp.right).offset(-16)
        make.top.equalTo(maskView.snp.top).offset(25)
    }
    return maskView
}
